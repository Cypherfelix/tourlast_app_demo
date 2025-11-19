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
    final durationText = DateTimeFormatter.formatDuration(duration);
    final stopsText = stops == 0
        ? 'Direct'
        : stops == 1
        ? '1 stop'
        : '$stops stops';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(
            child: _TimeColumn(
              alignment: CrossAxisAlignment.start,
              time: DateTimeFormatter.formatTime(departureTime),
              airport: origin,
              icon: Icons.flight_takeoff_rounded,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Column(
            children: [
              _RouteLine(),
              const SizedBox(height: AppSpacing.xs),
              Text(
                durationText,
                style: AppTypography.textTheme.labelMedium?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                stopsText,
                style: AppTypography.textTheme.labelSmall?.copyWith(
                  color: stops == 0 ? AppColors.success : AppColors.warning,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: _TimeColumn(
              alignment: CrossAxisAlignment.end,
              time: DateTimeFormatter.formatTime(arrivalTime),
              airport: destination,
              icon: Icons.flight_land_rounded,
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeColumn extends StatelessWidget {
  const _TimeColumn({
    required this.alignment,
    required this.time,
    required this.airport,
    required this.icon,
  });

  final CrossAxisAlignment alignment;
  final String time;
  final String airport;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          time,
          style: AppTypography.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Row(
          mainAxisAlignment: alignment == CrossAxisAlignment.end
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (alignment == CrossAxisAlignment.start)
              Icon(icon, size: 16, color: AppColors.primaryBlue),
            if (alignment == CrossAxisAlignment.start)
              const SizedBox(width: AppSpacing.xxs),
            Text(
              airport,
              style: AppTypography.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
                letterSpacing: 0.4,
              ),
            ),
            if (alignment == CrossAxisAlignment.end)
              const SizedBox(width: AppSpacing.xxs),
            if (alignment == CrossAxisAlignment.end)
              Icon(icon, size: 16, color: AppColors.accentAqua),
          ],
        ),
      ],
    );
  }
}

class _RouteLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Dot(color: AppColors.primaryBlue),
        Container(width: 56, height: 2, color: AppColors.border),
        _Dot(color: AppColors.accentAqua),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
