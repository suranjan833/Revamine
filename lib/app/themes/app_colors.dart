import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Backgrounds
  static const Color bgDark = Color(0xff020A24);
  static const Color bgCard = Color(0xff0A1230);
  static const Color bgCard2 = Color(0xff151D35);
  static const Color bgNav = Color(0xff0E1735);

  // Primary
  static const Color primary = Color(0xffA855F7);
  static const Color primaryDark = Color(0xff7C3AED);
  static const Color primaryGlow = Color(0x40A855F7);

  // Accent
  static const Color accent = Color(0xff00FFD0);
  static const Color accentDark = Color(0xff003B46);

  // Functional
  static const Color success = Color(0xff4ADE80);
  static const Color warning = Color(0xffFF7A00);
  static const Color error = Color(0xffEF4444);
  static const Color info = Color(0xff3078FF);

  // Task / Mission colors
  static const Color taskBlue = Color(0xff3078FF);
  static const Color missionPurple = Color(0xffB44BFF);
  static const Color checkinGreen = Color(0xff00A86B);

  // Text
  static Color textPrimary = Colors.white;
  static Color textSecondary = Colors.white.withValues(alpha: 0.5);
  static Color textTertiary = Colors.white.withValues(alpha: 0.35);

  // Borders
  static Color borderLight = Colors.white.withValues(alpha: 0.06);
  static Color borderMedium = Colors.white.withValues(alpha: 0.1);
}
