import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/flight/fare_itinerary.dart';
import '../../../providers/flight_providers.dart';
import '../filters/filter_models.dart';
import '../flight_card/flight_card.dart';
import '../shimmer/flight_card_shimmer.dart';

/// List of flight cards with loading and error states.
class FlightList extends ConsumerWidget {
  const FlightList({
    super.key,
    this.onFlightTap,
    this.filters,
  });

  final void Function(FareItinerary)? onFlightTap;
  final FlightFilters? filters;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = this.filters ?? FlightFilters.empty();
    final flightsAsync = ref.watch(filteredFlightListProvider(filters));

    return flightsAsync.when(
      data: (flights) {
        if (flights.isEmpty) {
          return _EmptyState(hasFilters: filters != FlightFilters.empty());
        }

        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(flightsProvider);
            await ref.read(flightsProvider.future);
          },
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            itemCount: flights.length,
            itemBuilder: (context, index) {
              return FlightCard(
                fareItinerary: flights[index],
                onTap: onFlightTap != null
                    ? () => onFlightTap!(flights[index])
                    : null,
                animationDelay: Duration(milliseconds: index * 50),
              );
            },
          ),
        );
      },
      loading: () => const _LoadingState(),
      error: (error, stackTrace) => _ErrorState(
        error: error,
        onRetry: () async {
          ref.invalidate(flightsProvider);
          await ref.read(flightsProvider.future);
        },
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      itemCount: 5,
      itemBuilder: (context, index) {
        return FlightCardShimmer(
          animationDelay: Duration(milliseconds: index * 100),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.hasFilters});

  final bool hasFilters;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            hasFilters
                ? Icons.filter_alt_off_rounded
                : Icons.flight_takeoff_rounded,
            size: 64,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            hasFilters
                ? 'No flights match your filters'
                : 'No flights found',
            style: AppTypography.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          if (hasFilters) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Try adjusting your filter criteria',
              style: AppTypography.textTheme.bodyMedium?.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded, size: 64, color: AppColors.error),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Failed to load flights',
              style: AppTypography.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              error.toString(),
              style: AppTypography.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
