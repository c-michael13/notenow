import 'package:flutter/material.dart';
import 'package:note_now/model/services/auth_service.dart';
import 'package:note_now/view/authentication/utils/auth_utils.dart';
import 'package:note_now/view_model/providers/create_account_provider.dart';
import 'package:note_now/view_model/widgets/custom_button.dart';
import 'package:note_now/view_model/widgets/form_textfield.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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

  bool isObsecure = true;
  bool isLoading = false;
  bool isLogin = true;
  bool isSignUp = false;

  @override
  Widget build(BuildContext context) {
    final acctDetails = ref.read(createAccountProvider.notifier);
    final loginProvider = ref.read(authServiceProvider);



    final screenWidth = Responsive.screenWidth(context);
    final screenHeight = Responsive.screenHeight(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              
              children: [
                Gap(screenHeight * 0.07),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    Assets.images.notenawLogo.path,
                    width: screenWidth * 0.3,
                    height: screenHeight * 0.12,
                    fit: BoxFit.cover,
                  ).animate()
                  .fadeIn(duration: 600.ms)
                  .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1))
                  .slide(begin: const Offset(0, -0.1), end: Offset.zero),
                ),
                Center(
                  child: Card(
                    elevation: 0.5,

                    color: AppColors.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    margin: EdgeInsets.only(top: screenHeight * 0.05),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20
                      ),
                      child: Column(
                        children: [
                          CustomText(
                            text: isLogin
                            ? "Welcome! Please log in to continue."
                            : "Create an account to get started.",
                            fontSize: Responsive.fontSize(context, 18),
                            fontWeight: FontWeight.bold,
                            
                          ).animate()
                          .fadeIn(duration: 500.ms, delay: 200.ms)
                          .slide(begin: const Offset(0, 0.2), end: Offset.zero),
                          Gap(screenHeight * 0.02),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: screenHeight * 0.01,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5
                                  ),
                                  child: CustomText(
                                    text: "Email",
                                    fontSize: Responsive.fontSize(context, 14),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                FormTextfield(
                                  controller: _emailController,
                                  hintText: "Enter your email",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    return null;
                                  },                    
                                ).animate()
                                .fadeIn(delay: 400.ms)
                                .slide(begin: const Offset(-0.1, 0), end: Offset.zero),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5
                                  ),
                                  child: CustomText(
                                    text: "Password",
                                    fontSize: Responsive.fontSize(context, 14),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                FormTextfield(
                                  controller: _passwordController,
                                  hintText: "Enter your password",
                                  obscureText: isObsecure,
                                  suffix: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isObsecure = !isObsecure;
                                      });
                                    },
                                    child: Icon(
                                        isObsecure ? Icons.visibility_off : Icons.visibility,
                                        color: AppColors.textPrimary,
                                      ),
                                  ),
                                   
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },                    
                                ).animate()
                                 .fadeIn(delay: 600.ms)
                                 .slide(begin: const Offset(-0.1, 0), end: Offset.zero),
                                
                                if(isLogin == true)
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      // Navigate to forgot password screen
                                    },
                                    child: CustomText(
                                      text: "Forgot Password?",
                                      fontSize: Responsive.fontSize(context, 14),
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ).animate()
                                    .fadeIn(delay: 800.ms)
                                    .shake(delay: 1200.ms),
                                  ),
                                )
                                
                              ],
                            ),
                          ),
                          Gap(screenHeight * 0.04),
                          CustomButton(
                            text: isLogin
                            ? "Continue"
                            : "Register",
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                if(isLogin) {
                                  showLoadingDialog(  context);
                                  // Call login function
                                  loginProvider.signinUser(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  ).then((result) async {
                                    if (result.success) {
                                      Navigator.of(context).pop();
                                      await Future.delayed(const Duration(seconds: 1));
                                      // Navigate to home page
                                      context.go('/home');
                                    } else {
                                      // Show error message
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(result.message ?? 'Login failed'),
                                        ),
                                      );
                                    }
                                  });
                                } else {
                                  // Call sign up function
                                  acctDetails.setEmail(_emailController.text.trim());
                                  acctDetails.setPassword(_passwordController.text.trim());

                                  context.go('/username');
                                }
                              }
                            },
                          ).animate()
                          .fadeIn(delay: 900.ms)
                          .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1))
                          .then(delay: 200.ms),
                          
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20
                            ),
                            child: isLogin
                            ? Row(
                              children: [
                                CustomText(
                                  text: "Don't have an account? ",
                                  fontSize: Responsive.fontSize(context, 14),
                                  fontWeight: FontWeight.w400,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isLogin = false;
                                      isSignUp = true;
                                    });
                                  },
                                  child: CustomText(
                                    text: "Sign Up",
                                    fontSize: Responsive.fontSize(context, 14),
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primary,
                                  ).animate()
                                    .fadeIn(delay: 1000.ms),
                                ),
                              ],
                            )
                            : Row(
                              children: [
                                CustomText(
                                  text: "Already have an account? ",
                                  fontSize: Responsive.fontSize(context, 14),
                                  fontWeight: FontWeight.w400,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isLogin = true;
                                      isSignUp = false;
                                    });
                                  },
                                  child: CustomText(
                                    text: "Log In",
                                    fontSize: Responsive.fontSize(context, 14),
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primary,
                                  ).animate()
                                    .fadeIn(delay: 1000.ms),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}