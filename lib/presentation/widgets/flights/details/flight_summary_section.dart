import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/date_time_formatter.dart';

/// Flight summary section with key flight information.
class FlightSummarySection extends StatelessWidget {
  const FlightSummarySection({
    super.key,
    required this.segments,
    required this.stops,
    required this.isRefundable,
  });

  final List<dynamic> segments;
  final int stops;
  final bool isRefundable;

  @override
  Widget build(BuildContext context) {
    final firstSegment = segments.isNotEmpty ? segments.first : null;
    final cabinClass = firstSegment?.cabinClassText ?? '';
    final totalDuration = _calculateTotalDuration(segments);

    return _buildSection(
      context,
      'Flight Information',
      Column(
        children: [
          _buildInfoRow(
            context,
            Icons.flight_rounded,
            'Stops',
            stops == 0 ? 'Direct' : '$stops ${stops == 1 ? 'stop' : 'stops'}',
          ),
          const Divider(),
          _buildInfoRow(
            context,
            Icons.access_time_rounded,
            'Duration',
            totalDuration,
          ),
          const Divider(),
          _buildInfoRow(
            context,
            Icons.event_seat_rounded,
            'Cabin Class',
            cabinClass,
          ),
          const Divider(),
          _buildInfoRow(
            context,
            Icons.info_outline_rounded,
            'Refund Policy',
            isRefundable ? 'Refundable' : 'Non-refundable',
          ),
        ],
      ),
    );
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

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: AppColors.primaryBlue,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              label,
              style: AppTypography.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Text(
            value,
            style: AppTypography.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  String _calculateTotalDuration(List<dynamic> segments) {
    if (segments.isEmpty) return '0h 0m';

    try {
      int totalMinutes = 0;
      for (final segment in segments) {
        final durationStr = segment.journeyDuration;
        final formatted = DateTimeFormatter.formatDuration(durationStr);
        // Parse formatted duration like "2h 30m" or "30m"
        final hoursMatch = RegExp(r'(\d+)\s*[hH]').firstMatch(formatted);
        final minutesMatch = RegExp(r'(\d+)\s*[mM]').firstMatch(formatted);
        final hours = hoursMatch != null ? int.parse(hoursMatch.group(1)!) : 0;
        final minutes =
            minutesMatch != null ? int.parse(minutesMatch.group(1)!) : 0;
        totalMinutes += hours * 60 + minutes;
      }

      final hours = totalMinutes ~/ 60;
      final minutes = totalMinutes % 60;
      return '${hours}h ${minutes}m';
    } catch (e) {
      return segments.first.journeyDuration;
    }
  }
}

