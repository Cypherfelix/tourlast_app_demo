import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

final class AppTypography {
  AppTypography._();

  static TextTheme get textTheme {
    final base = GoogleFonts.plusJakartaSansTextTheme();
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -1,
      ),
      displayMedium: base.displayMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      headlineLarge: base.headlineLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: -0.2,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      ),
      bodySmall: base.bodySmall?.copyWith(color: AppColors.textTertiary),
      labelLarge: base.labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: 0.5,
      ),
      labelMedium: base.labelMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
      ),
      labelSmall: base.labelSmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.textTertiary,
      ),
    );
  }
}
