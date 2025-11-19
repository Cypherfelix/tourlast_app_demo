import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';

/// Cabin class filter section.
class CabinFilterSection extends StatelessWidget {
  const CabinFilterSection({
    super.key,
    required this.selectedCabins,
    required this.onChanged,
  });

  final List<String> selectedCabins;
  final ValueChanged<List<String>> onChanged;

  static const List<String> _cabinOptions = [
    'Economy',
    'Premium Economy',
    'Business',
    'First',
  ];

  void _toggleCabin(String cabin) {
    final newList = List<String>.from(selectedCabins);
    if (newList.contains(cabin)) {
      newList.remove(cabin);
    } else {
      newList.add(cabin);
    }
    onChanged(newList);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.flight_class_rounded,
              size: 18,
              color: AppColors.primaryBlue,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'Cabin Class',
              style: AppTypography.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            if (selectedCabins.isNotEmpty) ...[
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
                  '${selectedCabins.length}',
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
          children: _cabinOptions.map((cabin) {
            final isSelected = selectedCabins.contains(cabin);
            return FilterChip(
              selected: isSelected,
              label: Text(
                cabin,
                style: AppTypography.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                ),
              ),
              onSelected: (_) => _toggleCabin(cabin),
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
