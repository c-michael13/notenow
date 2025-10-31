import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_now/view_model/constants/app_color.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  const CustomText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.textPrimary;

    return Text(
      text,
      style: GoogleFonts.akatab(
        fontSize: fontSize,
        color: textColor,
        fontWeight: fontWeight,
        
      ),
    );
  }
}