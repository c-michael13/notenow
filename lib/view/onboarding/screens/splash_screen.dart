import 'package:note_now/view/onboarding/utils/onboarding_utils.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final responsive = Responsive();


  final Color backgroundColor = AppColors.background;

  void navigateToOnboarding() {
    Future.delayed(const Duration(seconds: 3), () {
      context.go('/onboarding');
    });
  }

  @override
  void initState() {
    navigateToOnboarding();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final width = Responsive.screenWidth(context);
    final height = Responsive.screenHeight(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Center(
            child: Image.asset(
              Assets.images.notenawLogo.path,
              width: width * 0.35,
              height: height * 0.25,
              fit: BoxFit.cover,
            
            ).animate()
            .fadeIn(duration: 800.ms)
            .scaleXY(begin: 0.5, end: 1.0, duration: 800.ms, curve: Curves.easeOut)
            .then(delay: 200.ms),
          ),
          Spacer(),
          CustomText(
            text: 'Welcome to NoteNow', 
            fontSize: Responsive.fontSize(context, 16), 
            fontWeight: FontWeight.bold,
          ).animate().fadeIn(duration: 1.seconds, delay: 500.ms),
          Gap(height * 0.07),
        ],
      )
    );
  }
}