import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/common/money.dart';

/// Footer section showing price and baggage info.
class FlightCardFooter extends StatelessWidget {
  const FlightCardFooter({super.key, required this.totalFare, this.baggage});

  final Money totalFare;
  final String? baggage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Baggage info
        if (baggage != null) ...[
          Row(
            children: [
              Icon(
                Icons.luggage_rounded,
                size: 18,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                baggage!,
                style: AppTypography.textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(width: AppSpacing.md),
        ],
        const Spacer(),
        // Price
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              totalFare.currencyCode,
              style: AppTypography.textTheme.labelSmall?.copyWith(
                color: AppColors.textTertiary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              totalFare.amount,
              style: AppTypography.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primaryBlue,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
