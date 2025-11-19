import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import 'airline_logo.dart';

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
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryBlue.withValues(alpha: 0.1),
                AppColors.accentAqua.withValues(alpha: 0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.primaryBlue.withValues(alpha: 0.2),
              width: 1.5,
            ),
          ),
          child: AirlineLogo(airlineCode: airlineCode),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                airlineName,
                style: AppTypography.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.xxs),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xxs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceMuted,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '$airlineCode $flightNumber',
                      style: AppTypography.textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  _CabinChip(label: cabinClass),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CabinChip extends StatelessWidget {
  const _CabinChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: AppTypography.textTheme.labelSmall?.copyWith(
          color: AppColors.primaryBlue,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
