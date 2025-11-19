import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../../../data/providers/repository_providers.dart';
import '../../flight_card/airline_logo.dart';

/// Airline filter section with multi-select.
class AirlineFilterSection extends ConsumerWidget {
  const AirlineFilterSection({
    super.key,
    required this.selectedAirlines,
    required this.onChanged,
  });

  final List<String> selectedAirlines;
  final ValueChanged<List<String>> onChanged;

  void _toggleAirline(String code, List<String> current) {
    final newList = List<String>.from(current);
    if (newList.contains(code)) {
      newList.remove(code);
    } else {
      newList.add(code);
    }
    onChanged(newList);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final airlinesAsync = ref.watch(airlinesProvider);

    return airlinesAsync.when(
      data: (airlines) {
        if (airlines.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.airlines_rounded,
                  size: 18,
                  color: AppColors.primaryBlue,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'Airlines',
                  style: AppTypography.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (selectedAirlines.isNotEmpty) ...[
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
                      '${selectedAirlines.length}',
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
              children: airlines.take(10).map((airline) {
                final isSelected = selectedAirlines.contains(
                  airline.airLineCode,
                );
                return GestureDetector(
                  onTap: () =>
                      _toggleAirline(airline.airLineCode, selectedAirlines),
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryBlue.withValues(alpha: 0.1)
                          : AppColors.surfaceMuted,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primaryBlue
                            : AppColors.border,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AirlineLogo(
                          airlineCode: airline.airLineCode,
                          width: 32,
                          height: 32,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          airline.airLineName,
                          style: AppTypography.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? AppColors.primaryBlue
                                : AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (isSelected) ...[
                          const SizedBox(width: AppSpacing.xs),
                          Icon(
                            Icons.check_circle_rounded,
                            size: 16,
                            color: AppColors.primaryBlue,
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
      loading: () => const SizedBox(
        height: 60,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

/// Provider for airlines list.
final airlinesProvider = FutureProvider((ref) async {
  final repository = ref.watch(airlineRepositoryProvider);
  return repository.getAirlines();
});
