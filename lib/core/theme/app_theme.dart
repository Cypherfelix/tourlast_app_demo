import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryBlue,
      onPrimary: Colors.white,
      secondary: AppColors.accentSunset,
      onSecondary: Colors.white,
      tertiary: AppColors.accentAqua,
      onTertiary: Colors.white,
      error: AppColors.error,
      onError: Colors.white,
      background: AppColors.surfaceMuted,
      onBackground: AppColors.textPrimary,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      surfaceTint: AppColors.primaryBlue,
      outline: AppColors.border,
      shadow: Colors.black26,
      primaryContainer: AppColors.skyGradientStart,
      onPrimaryContainer: AppColors.textPrimary,
      secondaryContainer: AppColors.skyGradientEnd,
      onSecondaryContainer: AppColors.textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.surfaceMuted,
      textTheme: AppTypography.textTheme,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: AppColors.textPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 2,
        margin: const EdgeInsets.all(AppSpacing.md),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        shadowColor: AppColors.primaryBlue.withOpacity(0.08),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          textStyle: AppTypography.textTheme.titleMedium,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceMuted,
        selectedColor: AppColors.primaryBlue.withOpacity(0.1),
        disabledColor: AppColors.surfaceMuted,
        side: const BorderSide(color: AppColors.border),
        labelStyle: AppTypography.textTheme.labelMedium,
        secondaryLabelStyle: AppTypography.textTheme.labelMedium,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: AppSpacing.lg,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: AppColors.primaryBlue,
            width: 1.4,
          ),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryBlue,
        linearTrackColor: AppColors.skyGradientEnd,
      ),
      iconTheme: const IconThemeData(color: AppColors.textSecondary),
    );
  }
}
