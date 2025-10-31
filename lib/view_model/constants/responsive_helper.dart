import 'package:flutter/material.dart';

/// A helper class to make your UI responsive across different screen sizes.
///
/// Usage:
/// ```dart
/// if (Responsive.isMobile(context)) {...}
/// double width = Responsive.screenWidth(context) * 0.5;
/// double font = Responsive.fontSize(context, 16);
/// ```
class Responsive {
  // Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;

  /// Returns screen width
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  /// Returns screen height
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  /// Check if screen is mobile size
  static bool isMobile(BuildContext context) =>
      screenWidth(context) < mobileBreakpoint;

  /// Check if screen is tablet size
  static bool isTablet(BuildContext context) =>
      screenWidth(context) >= mobileBreakpoint &&
      screenWidth(context) < tabletBreakpoint;

  /// Check if screen is desktop size
  static bool isDesktop(BuildContext context) =>
      screenWidth(context) >= tabletBreakpoint;

  /// Responsive font size
  static double fontSize(BuildContext context, double size) {
    if (isMobile(context)) return size;
    if (isTablet(context)) return size * 1.2;
    return size * 1.4; // Desktop
  }

  /// Responsive padding
  static EdgeInsets symmetricPadding(
      BuildContext context, double horizontal, double vertical) {
    if (isMobile(context)) {
      return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
    } else if (isTablet(context)) {
      return EdgeInsets.symmetric(
          horizontal: horizontal * 1.5, vertical: vertical * 1.2);
    } else {
      return EdgeInsets.symmetric(
          horizontal: horizontal * 2, vertical: vertical * 1.5);
    }
  }

  /// Responsive size multiplier for containers or widgets
  static double scale(BuildContext context, double value) {
    double width = screenWidth(context);
    if (width < mobileBreakpoint) return value;
    if (width < tabletBreakpoint) return value * 1.3;
    return value * 1.6;
  }
}
