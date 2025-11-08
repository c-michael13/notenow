import 'package:note_now/model/services/auth_service.dart';
import 'package:note_now/view/authentication/utils/auth_utils.dart';
import 'package:note_now/view/onboarding/utils/onboarding_utils.dart';
import 'package:note_now/view_model/providers/create_account_provider.dart';
import 'package:note_now/view_model/widgets/custom_button.dart';
import 'package:note_now/view_model/widgets/form_textfield.dart';

class UsernamePage extends ConsumerStatefulWidget {
  const UsernamePage({super.key});

  @override
  ConsumerState<UsernamePage> createState() => _UsernamePageState();
}

class _UsernamePageState extends ConsumerState<UsernamePage> {
  final TextEditingController _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return Center(
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: const CircularProgressIndicator(),
          ),
        ),
      );
      
    },
  );
}

  @override
  Widget build(BuildContext context) {
    final emailAddress = ref.watch(createAccountProvider).email;
    final password = ref.watch(createAccountProvider).password;

    final createAccount = ref.read(authServiceProvider);



    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              Row(
                spacing: 10,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  CustomText(
                    text: 'Choose a Username',
                    fontSize: Responsive.fontSize(context, 20),
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
              Gap(20),
              CustomText(
                text: "What's the name you'd like us to use when we greet you and interact with you?",
                fontSize: Responsive.fontSize(context, 18),
                fontWeight: FontWeight.w400,
              ),
              Gap(30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    FormTextfield(
                      hintText: 'Enter your username',
                      keyboardType: TextInputType.text,
                      controller: _usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a username';
                        }
                        if (value.length < 3) {
                          return 'Username must be at least 3 characters long';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              Spacer(),
              CustomButton(
                text: "Continue",
                onTap: ()  {
                  if (_formKey.currentState!.validate()) {
                    showLoadingDialog(context);

                    // Save username to provider
                    ref.read(createAccountProvider.notifier).setUsername(_usernameController.text.trim());
                    
                    // Create account
                    createAccount.createAccount(
                      email: emailAddress,
                      password: password,
                      username: _usernameController.text.trim(),
                    ).then((result) async {
                      if (result.success) {

                        Navigator.of(context).pop();

                        await Future.delayed(const Duration(seconds: 1));

                        context.go('/home');

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Account created successfully!')),
                        );
                      } else {
                        // Handle errors
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result.message ?? 'Account creation failed')),
                        );
                      }
                    });
                    
                  } 
                  
                },
              ),
              Gap(20),
            ],
          ),
        ),
      )
    );
  }
}