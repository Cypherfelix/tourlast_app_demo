import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import 'airline_logo_placeholder.dart';

/// Header section of flight card showing airline info.
class FlightCardHeader extends StatelessWidget {
  const FlightCardHeader({
    super.key,
    required this.airlineCode,
    required this.airlineName,
    required this.flightNumber,
    required this.cabinClass,
  });

  final String airlineCode;
  final String airlineName;
  final String flightNumber;
  final String cabinClass;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Airline logo placeholder (will be replaced with actual logo in Story 5.2)
        const AirlineLogoPlaceholder(),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                airlineName,
                style: AppTypography.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Row(
                children: [
                  Text(
                    '$airlineCode $flightNumber',
                    style: AppTypography.textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xxs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceMuted,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      cabinClass,
                      style: AppTypography.textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
