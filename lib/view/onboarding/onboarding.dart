import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:note_now/gen/assets.gen.dart';
import 'package:note_now/view_model/constants/app_color.dart';
import 'package:note_now/view_model/constants/responsive_helper.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = Responsive.screenWidth(context);
    final height = Responsive.screenHeight(context);
    final primaryColor = AppColors.primary;
    final textColor = AppColors.textPrimary;
    final textSecondaryColor = AppColors.textSecondary;
    final padding = Responsive.symmetricPadding(context, 20, 10);

    // Pages
    final List<PageViewModel> pages = [
      PageViewModel(
        title: "Capture your thoughts in seconds",
        body: "Jot ideas, notes, and reminders instantly — before inspiration slips away.",
        image: Image.asset(
          Assets.images.girlNote.path,
        ),
        decoration: PageDecoration(
          titleTextStyle: TextStyle(
            fontSize: Responsive.fontSize(context, 24),
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
          bodyTextStyle: TextStyle(
            fontSize: Responsive.fontSize(context, 16),
            color: textSecondaryColor,
        ),
      )
      ),
      PageViewModel(
        title: "Your notes, reimagined by AI.",
        body: "Let AI organize, summarize, and uncover insights from your thoughts — effortlessly.",
        image: Image.asset(
          Assets.images.brain.path,
        ),
        decoration: PageDecoration(
          titleTextStyle: TextStyle(
            fontSize: Responsive.fontSize(context, 24),
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
          bodyTextStyle: TextStyle(
            fontSize: Responsive.fontSize(context, 16),
            color: textSecondaryColor,
          ),
        ),
      ),
    ];


    return Scaffold(
      body: Column(
        children: [
          Gap(height * 0.1),
          Expanded(
            child: IntroductionScreen(
              pages: pages,
              onDone: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              showSkipButton: true,
              skip: Text("Skip", style: TextStyle(color: textColor, fontSize: Responsive.fontSize(context, 16))),
              next: Container(
                
                child: Icon(
                  Icons.arrow_forward, 
                  color: primaryColor,
                ),
              ),
              done: Text("Done", style: TextStyle(color: primaryColor, fontWeight: FontWeight.w600, fontSize: Responsive.fontSize(context, 16))),
              dotsDecorator: DotsDecorator(
                activeColor: primaryColor,
                size: Size.square(8.0),
                activeSize: Size(16.0, 8.0),
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
              globalBackgroundColor: AppColors.background,
              // globalFooter: Padding(
              //   padding: padding,
              //   child: Text(
              //     "NoteNow - Your AI-Powered Note Taking App",
              //     style: TextStyle(color: textColor, fontSize: Responsive.fontSize(context, 14)),
              //     textAlign: TextAlign.center,
              //   ),
              // ),
            ),
          ),

          // Text(
          //   "My lovely girlfriend thinks she can learn code",
          //   style: TextStyle(
          //     color: Colors.purple,
          //   ),

          // ),
          Gap(height * 0.02),
        ],
      ),
    );
  }
}