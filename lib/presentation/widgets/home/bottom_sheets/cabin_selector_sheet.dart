import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class CabinSelectorSheet extends StatelessWidget {
  const CabinSelectorSheet({
    super.key,
    required this.selectedCabin,
    required this.cabins,
    required this.onSelect,
  });

  final String selectedCabin;
  final List<String> cabins;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.lg,
            ),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Text(
              'Select Cabin Class',
              style: AppTypography.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          ...cabins.map(
            (cabin) => ListTile(
              title: Text(cabin),
              trailing: cabin == selectedCabin
                  ? Icon(Icons.check_circle, color: AppColors.primaryBlue)
                  : null,
              onTap: () => onSelect(cabin),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}
