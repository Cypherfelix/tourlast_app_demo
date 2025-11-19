import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

/// Placeholder for airline logo (will be replaced with actual logo in Story 5.2).
class AirlineLogoPlaceholder extends StatelessWidget {
  const AirlineLogoPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Icon(
        Icons.airlines_rounded,
        size: 26,
        color: AppColors.primaryBlue,
      ),
    );
  }
}
