import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_now/view_model/constants/app_color.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  const CustomText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = AppColors.textPrimary;

    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        color: color ?? textColor,
        fontWeight: fontWeight,
        
      ),
    );
  }
}