import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';

/// Baggage filter section.
class BaggageFilterSection extends StatelessWidget {
  const BaggageFilterSection({
    super.key,
    this.hasBaggage,
    required this.onChanged,
  });

  final bool? hasBaggage;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.luggage_rounded, size: 18, color: AppColors.primaryBlue),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'Baggage',
              style: AppTypography.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            if (hasBaggage != null) ...[
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
        Row(
          children: [
            Expanded(
              child: _BaggageOption(
                label: 'With Baggage',
                isSelected: hasBaggage == true,
                onTap: () => onChanged(hasBaggage == true ? null : true),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _BaggageOption(
                label: 'No Baggage',
                isSelected: hasBaggage == false,
                onTap: () => onChanged(hasBaggage == false ? null : false),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _BaggageOption extends StatelessWidget {
  const _BaggageOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue : AppColors.surfaceMuted,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTypography.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
