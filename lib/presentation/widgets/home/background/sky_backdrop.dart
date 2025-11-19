import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import 'circle_blur.dart';

class SkyBackdrop extends StatelessWidget {
  const SkyBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.skyGradientStart, AppColors.surfaceMuted],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -60,
            right: -30,
            child: CircleBlur(size: 200, color: AppColors.accentAqua.withValues(alpha: 0.15)),
          ),
          Positioned(
            top: 120,
            left: -40,
            child: CircleBlur(
              size: 160,
              color: AppColors.accentAqua.withValues(alpha: .2),
            ),
          ),
        ],
      ),
    );
  }
}
