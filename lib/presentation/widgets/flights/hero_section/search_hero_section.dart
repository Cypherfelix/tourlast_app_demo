import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../widgets/home/models/search_params.dart';

/// Collapsible hero section showing compact search parameters.
class SearchHeroSection extends StatelessWidget {
  const SearchHeroSection({
    super.key,
    required this.searchParams,
    required this.isExpanded,
    this.flightCount,
  });

  final SearchParams searchParams;
  final bool isExpanded;
  final int? flightCount;

  String get _travelersText {
    final parts = <String>[];
    if (searchParams.adults > 0) {
      parts.add(
        '${searchParams.adults} Adult${searchParams.adults > 1 ? 's' : ''}',
      );
    }
    if (searchParams.children > 0) {
      parts.add(
        '${searchParams.children} Child${searchParams.children > 1 ? 'ren' : ''}',
      );
    }
    if (searchParams.infants > 0) {
      parts.add(
        '${searchParams.infants} Infant${searchParams.infants > 1 ? 's' : ''}',
      );
    }
    return parts.join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
      child: isExpanded
          ? Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surfaceMuted,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.sm,
                  children: [
                    _InfoChip(
                      icon: Icons.people_outline_rounded,
                      label: 'Travelers',
                      value: _travelersText.isEmpty
                          ? '1 Adult'
                          : _travelersText,
                    ),
                    _InfoChip(
                      icon: Icons.flight_class_rounded,
                      label: 'Cabin',
                      value: searchParams.cabinClass,
                    ),
                    if (flightCount != null)
                      _InfoChip(
                        icon: Icons.flight_takeoff_rounded,
                        label: 'Flights',
                        value:
                            '$flightCount ${flightCount == 1 ? 'result' : 'results'}',
                      ),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.primaryBlue),
          const SizedBox(width: AppSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: AppTypography.textTheme.labelSmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: AppTypography.textTheme.bodySmall?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
