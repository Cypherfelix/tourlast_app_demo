import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

/// Placeholder for airline logo (will be replaced with actual logo in Story 5.2).
class AirlineLogoPlaceholder extends StatelessWidget {
  const AirlineLogoPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Icon(
        Icons.airlines_rounded,
        size: 28,
        color: AppColors.primaryBlue.withValues(alpha: 0.6),
      ),
    );
  }
}
