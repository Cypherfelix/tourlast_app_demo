import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';
import 'filter_models.dart';
import 'filter_sections/airline_filter_section.dart';
import 'filter_sections/baggage_filter_section.dart';
import 'filter_sections/cabin_filter_section.dart';
import 'filter_sections/price_filter_section.dart';
import 'filter_sections/stops_filter_section.dart';
import 'filter_sections/time_filter_section.dart';

/// Collapsible filter panel with all flight filters.
class FilterPanel extends StatefulWidget {
  const FilterPanel({
    super.key,
    required this.filters,
    required this.onFiltersChanged,
    this.scrollController,
  });

  final FlightFilters filters;
  final ValueChanged<FlightFilters> onFiltersChanged;
  final ScrollController? scrollController;

  @override
  State<FilterPanel> createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  late FlightFilters _currentFilters;

  @override
  void initState() {
    super.initState();
    _currentFilters = widget.filters;
  }

  @override
  void didUpdateWidget(FilterPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.filters != oldWidget.filters) {
      _currentFilters = widget.filters;
    }
  }

  void _updateFilters(FlightFilters newFilters) {
    setState(() {
      _currentFilters = newFilters;
    });
    widget.onFiltersChanged(newFilters);
  }

  void _resetFilters() {
    final resetFilters = FlightFilters.empty();
    _updateFilters(resetFilters);
  }

  int get _activeFilterCount {
    int count = 0;
    if (_currentFilters.selectedAirlines.isNotEmpty) count++;
    if (_currentFilters.minPrice != null || _currentFilters.maxPrice != null) {
      count++;
    }
    if (_currentFilters.departureTimeRanges.isNotEmpty) count++;
    if (_currentFilters.selectedCabins.isNotEmpty) count++;
    if (_currentFilters.maxStops != null) count++;
    if (_currentFilters.hasBaggage != null) count++;
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
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
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              children: [
                Icon(
                  Icons.tune_rounded,
                  color: AppColors.primaryBlue,
                  size: 20,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'Filters',
                  style: AppTypography.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (_activeFilterCount > 0) ...[
                  const SizedBox(width: AppSpacing.sm),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$_activeFilterCount',
                      style: AppTypography.textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
                const Spacer(),
                if (_activeFilterCount > 0)
                  TextButton(
                    onPressed: _resetFilters,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                    ),
                    child: Text(
                      'Reset',
                      style: AppTypography.textTheme.labelMedium?.copyWith(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  color: AppColors.textSecondary,
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Filter sections
          Flexible(
            child: SingleChildScrollView(
              controller: widget.scrollController,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price Range
                  PriceFilterSection(
                    minPrice: _currentFilters.minPrice,
                    maxPrice: _currentFilters.maxPrice,
                    onChanged: (min, max) {
                      _updateFilters(
                        _currentFilters.copyWith(minPrice: min, maxPrice: max),
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  // Departure Time
                  TimeFilterSection(
                    selectedRanges: _currentFilters.departureTimeRanges,
                    onChanged: (ranges) {
                      _updateFilters(
                        _currentFilters.copyWith(departureTimeRanges: ranges),
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  // Stops
                  StopsFilterSection(
                    maxStops: _currentFilters.maxStops,
                    onChanged: (maxStops) {
                      _updateFilters(
                        _currentFilters.copyWith(maxStops: maxStops),
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  // Airlines
                  AirlineFilterSection(
                    selectedAirlines: _currentFilters.selectedAirlines,
                    onChanged: (airlines) {
                      _updateFilters(
                        _currentFilters.copyWith(selectedAirlines: airlines),
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  // Cabin Class
                  CabinFilterSection(
                    selectedCabins: _currentFilters.selectedCabins,
                    onChanged: (cabins) {
                      _updateFilters(
                        _currentFilters.copyWith(selectedCabins: cabins),
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  // Baggage
                  BaggageFilterSection(
                    hasBaggage: _currentFilters.hasBaggage,
                    onChanged: (hasBaggage) {
                      _updateFilters(
                        _currentFilters.copyWith(hasBaggage: hasBaggage),
                      );
                    },
                  ),
                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
