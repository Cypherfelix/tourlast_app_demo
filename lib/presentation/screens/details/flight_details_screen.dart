import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/app_transitions.dart';
import '../../../data/models/flight/fare_itinerary.dart';
import '../../providers/flight_details_providers.dart';
import '../../screens/booking/booking_summary_screen.dart';
import '../../widgets/flights/details/flight_timeline_section.dart';
import '../../widgets/flights/details/flight_summary_section.dart';
import '../../widgets/flights/details/fare_breakdown_card.dart';
import '../../widgets/flights/details/extra_services_section.dart';
import '../../widgets/flights/flight_card/airline_logo.dart';
import '../../widgets/home/models/search_params.dart';

/// Flight details screen showing comprehensive flight information.
class FlightDetailsScreen extends ConsumerStatefulWidget {
  const FlightDetailsScreen({
    super.key,
    required this.fareItinerary,
    this.searchParams,
  });

  final FareItinerary fareItinerary;
  final SearchParams? searchParams;

  @override
  ConsumerState<FlightDetailsScreen> createState() =>
      _FlightDetailsScreenState();
}

class _FlightDetailsScreenState extends ConsumerState<FlightDetailsScreen>
    with AutomaticKeepAliveClientMixin {
  late final ScrollController _scrollController;
  late final String _flightId;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _flightId = generateFlightId(widget.fareItinerary);
    _scrollController = ScrollController();

    // Initialize state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(flightDetailsStateProvider(_flightId).notifier)
          .initialize(widget.fareItinerary);

      // Restore scroll position
      final savedPosition = ref
          .read(flightDetailsStateProvider(_flightId))
          .scrollPosition;
      if (savedPosition > 0 && _scrollController.hasClients) {
        _scrollController.jumpTo(savedPosition);
      }
    });

    // Save scroll position
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        ref
            .read(flightDetailsStateProvider(_flightId).notifier)
            .updateScrollPosition(_scrollController.offset);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    final state = ref.watch(flightDetailsStateProvider(_flightId));
    final fareItinerary = state.fareItinerary ?? widget.fareItinerary;

    final segments = _getAllSegments(fareItinerary);
    final firstSegment = segments.isNotEmpty ? segments.first : null;
    final lastSegment = segments.isNotEmpty ? segments.last : null;
    final airlineCode = firstSegment?.marketingAirlineCode ?? '';
    final airlineName = firstSegment?.marketingAirlineName ?? '';
    final stops = _getNumberOfStops(fareItinerary);
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
              controller: _scrollController,
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
                  ExtraServicesSection(
                    selectedServices: state.selectedServices,
                    onServiceQuantityChanged: (serviceId, quantity) {
                      ref
                          .read(flightDetailsStateProvider(_flightId).notifier)
                          .updateServiceQuantity(serviceId, quantity);
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  
                  // Proceed to Booking Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {
                          final searchParams = widget.searchParams;
                          if (searchParams == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Search parameters not available'),
                                backgroundColor: AppColors.error,
                              ),
                            );
                            return;
                          }
                          
                          Navigator.of(context).push(
                            AppTransitions.slideFromRight(
                              BookingSummaryScreen(
                                fareItinerary: fareItinerary,
                                searchParams: searchParams,
                                flightId: _flightId,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.arrow_forward_rounded),
                        label: const Text('Proceed to Booking'),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
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
    final fareItinerary = widget.fareItinerary;

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

  List<dynamic> _getAllSegments(FareItinerary fareItinerary) {
    final segments = <dynamic>[];
    for (final option in fareItinerary.airItinerary.originDestinationOptions) {
      for (final item in option.originDestinationOption) {
        segments.add(item.flightSegment);
      }
    }
    return segments;
  }

  int _getNumberOfStops(FareItinerary fareItinerary) {
    if (fareItinerary.airItinerary.originDestinationOptions.isEmpty) return 0;
    return fareItinerary.airItinerary.originDestinationOptions.first.totalStops;
  }
}
