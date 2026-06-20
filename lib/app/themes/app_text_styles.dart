import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Section labels (e.g. "AVAILABLE POINTS", "QUICK ACTIONS")
  static TextStyle get label => TextStyle(
    color: AppColors.textSecondary,
    fontSize: 10.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.2,
  );

  // Large value numbers (e.g. points count)
  static TextStyle get value => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 36.sp,
    fontWeight: FontWeight.w800,
    height: 0.95,
  );

  // Heading (e.g. "Beginner")
  static TextStyle get heading => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 28.sp,
    fontWeight: FontWeight.w700,
    height: 0.95,
  );

  // Title (e.g. card titles)
  static TextStyle get title => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 17.sp,
    fontWeight: FontWeight.w700,
    height: 1.1,
  );

  // Body text
  static TextStyle get body =>
      TextStyle(color: AppColors.textSecondary, fontSize: 13.sp);

  // Small / caption
  static TextStyle get caption =>
      TextStyle(color: AppColors.textTertiary, fontSize: 11.sp, height: 1.2);

  // Button text
  static TextStyle get button => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
  );

  // Greeting name (e.g. "SBS!")
  static TextStyle get greeting => TextStyle(
    color: AppColors.textPrimary,
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.3,
  );
}
