import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/flight/fare_itinerary.dart';
import '../../widgets/flights/details/flight_timeline_section.dart';
import '../../widgets/flights/details/flight_summary_section.dart';
import '../../widgets/flights/details/fare_breakdown_card.dart';
import '../../widgets/flights/details/extra_services_section.dart';
import '../../widgets/flights/flight_card/airline_logo.dart';

/// Flight details screen showing comprehensive flight information.
class FlightDetailsScreen extends ConsumerWidget {
  const FlightDetailsScreen({super.key, required this.fareItinerary});

  final FareItinerary fareItinerary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final segments = _getAllSegments();
    final firstSegment = segments.isNotEmpty ? segments.first : null;
    final lastSegment = segments.isNotEmpty ? segments.last : null;
    final airlineCode = firstSegment?.marketingAirlineCode ?? '';
    final airlineName = firstSegment?.marketingAirlineName ?? '';
    final stops = _getNumberOfStops();
    final totalFare =
        fareItinerary.airItineraryFareInfo.itinTotalFares.totalFare;
    final isRefundable =
        fareItinerary.airItineraryFareInfo.isRefundable.toLowerCase() == 'yes';

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Column(
        children: [
          // Header with gradient
          _buildHeader(
            context,
            ref,
            airlineCode,
            airlineName,
            firstSegment,
            lastSegment,
            totalFare.amount,
            totalFare.currencyCode,
          ),
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.md),
                  // Flight timeline
                  FlightTimelineSection(fareItinerary: fareItinerary),
                  const SizedBox(height: AppSpacing.md),
                  // Flight summary
                  FlightSummarySection(
                    segments: segments,
                    stops: stops,
                    isRefundable: isRefundable,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  // Fare breakdown
                  FareBreakdownCard(
                    fareInfo: fareItinerary.airItineraryFareInfo,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  // Extra services
                  ExtraServicesSection(),
                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    WidgetRef ref,
    String airlineCode,
    String airlineName,
    dynamic firstSegment,
    dynamic lastSegment,
    String price,
    String currencyCode,
  ) {
    final flightNumber = firstSegment?.flightNumber ?? '';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        bottom: AppSpacing.md,
        left: AppSpacing.md,
        right: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryBlue,
            AppColors.primaryBlue.withValues(alpha: 0.85),
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Back button and title row
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(10),
                  ),
                  icon: const Icon(Icons.arrow_back_rounded, size: 20),
                ),
                const Spacer(),
                Text(
                  'Flight Details',
                  style: AppTypography.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                // Spacer to balance the back button
                const SizedBox(width: 48),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            // Compact header content
            Row(
              children: [
                // Airline logo
                Consumer(
                  builder: (context, ref, child) {
                    final airlineLogoAsync = ref.watch(
                      airlineByCodeProvider(airlineCode),
                    );
                    return airlineLogoAsync.when(
                      data: (airline) {
                        return Hero(
                          tag:
                              'airline_logo_${airlineCode}_${fareItinerary.hashCode}',
                          child: AirlineLogo(
                            airlineCode: airlineCode,
                            width: 56,
                            height: 56,
                          ),
                        );
                      },
                      loading: () => Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                              strokeWidth: 2,
                            ),
                          ),
                        ),
                      ),
                      error: (_, __) => Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.flight_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(width: AppSpacing.md),
                // Route and flight number
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // From → To
                      if (firstSegment != null && lastSegment != null)
                        Row(
                          children: [
                            Expanded(
                              child: _buildCompactRoute(
                                'From',
                                firstSegment.departureAirportLocationCode,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                              ),
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white.withValues(alpha: 0.8),
                                size: 18,
                              ),
                            ),
                            Expanded(
                              child: _buildCompactRoute(
                                'To',
                                lastSegment.arrivalAirportLocationCode,
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: AppSpacing.xs),
                      // Flight number
                      if (flightNumber.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.flight_rounded,
                                size: 14,
                                color: Colors.white.withValues(alpha: 0.9),
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                '$airlineCode $flightNumber',
                                style: AppTypography.textTheme.labelMedium
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactRoute(String label, String airportCode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.textTheme.labelSmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          airportCode,
          style: AppTypography.textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  List<dynamic> _getAllSegments() {
    final segments = <dynamic>[];
    for (final option in fareItinerary.airItinerary.originDestinationOptions) {
      for (final item in option.originDestinationOption) {
        segments.add(item.flightSegment);
      }
    }
    return segments;
  }

  int _getNumberOfStops() {
    if (fareItinerary.airItinerary.originDestinationOptions.isEmpty) return 0;
    return fareItinerary.airItinerary.originDestinationOptions.first.totalStops;
  }
}
