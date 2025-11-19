import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/date_time_formatter.dart';

/// Route section showing origin, destination, times, and duration.
class FlightCardRoute extends StatelessWidget {
  const FlightCardRoute({
    super.key,
    required this.origin,
    required this.destination,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.stops,
  });

  final String origin;
  final String destination;
  final DateTime? departureTime;
  final DateTime? arrivalTime;
  final String duration;
  final int stops;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Departure
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateTimeFormatter.formatTime(departureTime),
                style: AppTypography.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                origin,
                style: AppTypography.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        // Route divider with duration
        Column(
          children: [
            Row(
              children: [
                Container(width: 40, height: 1, color: AppColors.border),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                  ),
                  child: Icon(
                    Icons.flight_takeoff_rounded,
                    size: 16,
                    color: AppColors.primaryBlue,
                  ),
                ),
                Container(width: 40, height: 1, color: AppColors.border),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time_rounded,
                  size: 14,
                  color: AppColors.textTertiary,
                ),
                const SizedBox(width: AppSpacing.xxs),
                Text(
                  DateTimeFormatter.formatDuration(duration),
                  style: AppTypography.textTheme.labelMedium?.copyWith(
                    color: AppColors.textTertiary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            if (stops > 0) ...[
              const SizedBox(height: AppSpacing.xxs),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  stops == 1 ? '1 stop' : '$stops stops',
                  style: AppTypography.textTheme.labelSmall?.copyWith(
                    color: AppColors.warning,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
        // Arrival
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateTimeFormatter.formatTime(arrivalTime),
                style: AppTypography.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                destination,
                style: AppTypography.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
