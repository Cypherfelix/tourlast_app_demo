import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';

/// Stops filter section.
class StopsFilterSection extends StatelessWidget {
  const StopsFilterSection({super.key, this.maxStops, required this.onChanged});

  final int? maxStops;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.flight_land_rounded,
              size: 18,
              color: AppColors.primaryBlue,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'Stops',
              style: AppTypography.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            if (maxStops != null) ...[
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
                  'Active',
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
          children: [
            _StopChip(
              label: 'Direct',
              stops: 0,
              isSelected: maxStops == 0,
              onTap: () => onChanged(maxStops == 0 ? null : 0),
              maxStops: maxStops,
            ),
            _StopChip(
              label: '1 Stop',
              stops: 1,
              isSelected: maxStops == 1,
              onTap: () => onChanged(maxStops == 1 ? null : 1),
              maxStops: maxStops,
            ),
            _StopChip(
              label: '2+ Stops',
              stops: 2,
              isSelected: maxStops != null && maxStops! >= 2,
              onTap: () =>
                  onChanged(maxStops != null && maxStops! >= 2 ? null : 2),
              maxStops: maxStops,
            ),
          ],
        ),
      ],
    );
  }
}

class _StopChip extends StatelessWidget {
  const _StopChip({
    required this.label,
    required this.stops,
    required this.isSelected,
    required this.onTap,
    required this.maxStops,
  });

  final String label;
  final int stops;
  final bool isSelected;
  final VoidCallback onTap;
  final int? maxStops;

  @override
  Widget build(BuildContext context) {

    return FilterChip(
      selected: isSelected,
      label: Text(
        label,
        style: AppTypography.textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.white : AppColors.textPrimary,
        ),
      ),
      onSelected: (_) => onTap(),
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
  }
}
