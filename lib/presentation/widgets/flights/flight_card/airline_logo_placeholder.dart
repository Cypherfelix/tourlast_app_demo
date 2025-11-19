import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

/// Placeholder for airline logo when logo is missing or loading.
class AirlineLogoPlaceholder extends StatelessWidget {
  const AirlineLogoPlaceholder({super.key, this.width = 52, this.height = 52});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Icon(
        Icons.airlines_rounded,
        size: width * 0.5,
        color: AppColors.primaryBlue,
      ),
    );
  }
}
