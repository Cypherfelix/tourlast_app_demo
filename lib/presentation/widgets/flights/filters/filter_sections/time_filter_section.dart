import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../filter_models.dart';

/// Departure time filter section.
class TimeFilterSection extends StatelessWidget {
  const TimeFilterSection({
    super.key,
    required this.selectedRanges,
    required this.onChanged,
  });

  final List<DepartureTimeRange> selectedRanges;
  final ValueChanged<List<DepartureTimeRange>> onChanged;

  void _toggleRange(DepartureTimeRange range) {
    final newRanges = List<DepartureTimeRange>.from(selectedRanges);
    if (newRanges.contains(range)) {
      newRanges.remove(range);
    } else {
      newRanges.add(range);
    }
    onChanged(newRanges);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.access_time_rounded,
              size: 18,
              color: AppColors.primaryBlue,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'Departure Time',
              style: AppTypography.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            if (selectedRanges.isNotEmpty) ...[
              const SizedBox(width: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${selectedRanges.length}',
                  style: AppTypography.textTheme.labelSmall?.copyWith(
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: DepartureTimeRange.values.map((range) {
            final isSelected = selectedRanges.contains(range);
            return FilterChip(
              selected: isSelected,
              label: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    range.label,
                    style: AppTypography.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    range.timeRange,
                    style: AppTypography.textTheme.labelSmall?.copyWith(
                      color: isSelected
                          ? Colors.white.withValues(alpha: 0.9)
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              onSelected: (_) => _toggleRange(range),
              selectedColor: AppColors.primaryBlue,
              checkmarkColor: Colors.white,
              side: BorderSide(
                color: isSelected ? AppColors.primaryBlue : AppColors.border,
                width: 1.5,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
