import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/date_time_formatter.dart';
import '../../../../data/models/flight/fare_itinerary.dart';

/// Timeline section showing all flight segments.
class FlightTimelineSection extends StatelessWidget {
  const FlightTimelineSection({super.key, required this.fareItinerary});

  final FareItinerary fareItinerary;

  @override
  Widget build(BuildContext context) {
    final segments = _getAllSegments();

    if (segments.isEmpty) {
      return const SizedBox.shrink();
    }

    return _buildSection(
      context,
      'Journey Details',
      Column(
        children: List.generate(segments.length, (index) {
          final segment = segments[index];
          final isLast = index == segments.length - 1;

          return Column(
            children: [
              _TimelineSegment(
                segment: segment,
                segmentNumber: index + 1,
                isLast: isLast,
              ),
              if (!isLast) _ConnectionInfo(segment: segment),
            ],
          );
        }),
      ),
    );
  }

  List<dynamic> _getAllSegments() {
    final segments = <dynamic>[];
    for (final option in fareItinerary.airItinerary.originDestinationOptions) {
      for (final item in option.originDestinationOption) {
        segments.add(item.flightSegment);
      }
    }
    return segments;
  }

  Widget _buildSection(BuildContext context, String title, Widget content) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          content,
        ],
      ),
    );
  }
}

class _TimelineSegment extends StatelessWidget {
  const _TimelineSegment({
    required this.segment,
    required this.segmentNumber,
    required this.isLast,
  });

  final dynamic segment;
  final int segmentNumber;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final departureTime = DateTimeFormatter.parseIsoDateTime(
      segment.departureDateTime,
    );
    final arrivalTime = DateTimeFormatter.parseIsoDateTime(
      segment.arrivalDateTime,
    );
    final duration = DateTimeFormatter.formatDuration(segment.journeyDuration);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline line and dot
        Column(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryBlue,
                border: Border.all(color: AppColors.surface, width: 1),
              ),
            ),
            if (!isLast)
              Container(
                width: 1,
                height: 100,
                color: AppColors.border,
                margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
              ),
          ],
        ),
        const SizedBox(width: AppSpacing.md),
        // Flight information
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Departure
              _TimeLocationRow(
                label: 'Departure',
                airportCode: segment.departureAirportLocationCode,
                time: departureTime != null
                    ? DateTimeFormatter.formatTime(departureTime)
                    : '',
                date: departureTime != null
                    ? DateTimeFormatter.formatShortDate(departureTime)
                    : '',
              ),
              const SizedBox(height: AppSpacing.md),
              // Flight number and airline (simplified)
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceMuted,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.flight_rounded,
                          size: 14,
                          color: AppColors.primaryBlue,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          '${segment.marketingAirlineCode} ${segment.flightNumber}',
                          style: AppTypography.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      segment.marketingAirlineName,
                      style: AppTypography.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              // Duration and cabin class
              Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    duration,
                    style: AppTypography.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      segment.cabinClassText,
                      style: AppTypography.textTheme.bodySmall?.copyWith(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              // Arrival
              _TimeLocationRow(
                label: 'Arrival',
                airportCode: segment.arrivalAirportLocationCode,
                time: arrivalTime != null
                    ? DateTimeFormatter.formatTime(arrivalTime)
                    : '',
                date: arrivalTime != null
                    ? DateTimeFormatter.formatShortDate(arrivalTime)
                    : '',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TimeLocationRow extends StatelessWidget {
  const _TimeLocationRow({
    required this.label,
    required this.airportCode,
    required this.time,
    required this.date,
  });

  final String label;
  final String airportCode;
  final String time;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                airportCode,
                style: AppTypography.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              time,
              style: AppTypography.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              date,
              style: AppTypography.textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ConnectionInfo extends StatelessWidget {
  const _ConnectionInfo({required this.segment});

  final dynamic segment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 28,
        top: AppSpacing.xs,
        bottom: AppSpacing.md,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.warning.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.warning.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.flight_land_rounded, size: 16, color: AppColors.warning),
            const SizedBox(width: AppSpacing.xs),
            Text(
              'Layover at ${segment.arrivalAirportLocationCode}',
              style: AppTypography.textTheme.bodySmall?.copyWith(
                color: AppColors.warning,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
