import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../providers/flight_providers.dart';
import '../../widgets/flights/flight_list/flight_list.dart';
import '../../widgets/flights/hero_section/search_hero_section.dart';
import '../../widgets/home/models/search_params.dart';

class ResultsScreen extends ConsumerStatefulWidget {
  const ResultsScreen({super.key, required this.searchParams});

  final SearchParams searchParams;

  @override
  ConsumerState<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends ConsumerState<ResultsScreen> {
  bool _showDetails = false;

  void _toggleDetails() {
    setState(() => _showDetails = !_showDetails);
  }

  String get _formattedDate =>
      DateFormat('EEE, d MMM yyyy').format(widget.searchParams.departureDate);

  @override
  Widget build(BuildContext context) {
    final flightsAsync = ref.watch(flightListProvider);
    final flightCount = flightsAsync.maybeWhen(
      data: (flights) => flights.length,
      orElse: () => null,
    );

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.skyGradientEnd,
              AppColors.surface,
              AppColors.surface,
            ],
            stops: const [0.0, 0.15, 1.0],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _HeaderBar(
                searchParams: widget.searchParams,
                formattedDate: _formattedDate,
                isExpanded: _showDetails,
                onToggleDetails: _toggleDetails,
              ),
              SearchHeroSection(
                searchParams: widget.searchParams,
                flightCount: flightCount,
                isExpanded: _showDetails,
              ),
              Expanded(
                child: FlightList(
                  onFlightTap: (fareItinerary) {
                    // TODO: Navigate to flight details in Story 6.1
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Flight ${fareItinerary.airItinerary.originDestinationOptions.firstOrNull?.originDestinationOption.firstOrNull?.flightSegment.flightNumber ?? 'N/A'} selected',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderBar extends StatelessWidget {
  const _HeaderBar({
    required this.searchParams,
    required this.formattedDate,
    required this.isExpanded,
    required this.onToggleDetails,
  });

  final SearchParams searchParams;
  final String formattedDate;
  final bool isExpanded;
  final VoidCallback onToggleDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            style: IconButton.styleFrom(
              padding: const EdgeInsets.all(10),
              backgroundColor: AppColors.surfaceMuted,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${searchParams.origin} → ${searchParams.destination}',
                  style: AppTypography.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: AppSpacing.xxs),
                    Text(
                      formattedDate,
                      style: AppTypography.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          TextButton.icon(
            onPressed: onToggleDetails,
            icon: Icon(
              isExpanded
                  ? Icons.expand_less_rounded
                  : Icons.expand_more_rounded,
              size: 18,
              color: AppColors.primaryBlue,
            ),
            label: Text(
              isExpanded ? 'Hide' : 'Details',
              style: AppTypography.textTheme.labelMedium?.copyWith(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.08),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
