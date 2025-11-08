import 'package:flutter/material.dart';
import 'package:note_now/view_model/constants/app_color.dart';

import 'package:note_now/view_model/constants/responsive_helper.dart';


class CustomButton extends StatelessWidget {
  final double? width;
  final String? text;
  final VoidCallback? onTap;
  const CustomButton({
    super.key,
    this.width,
    this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final height = Responsive.screenHeight(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height * 0.05,
        width: width ?? Responsive.screenWidth(context),
        decoration: BoxDecoration(
          color: AppColors.secondary.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Center(
          child: Text(
            "$text",
            style: TextStyle(
              color: Colors.white,
              fontSize: Responsive.fontSize(context, 16),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}