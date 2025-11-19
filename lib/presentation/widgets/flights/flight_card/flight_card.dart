import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/utils/date_time_formatter.dart';
import '../../../../data/models/flight/fare_itinerary.dart';
import 'flight_card_header.dart';
import 'flight_card_route.dart';
import 'flight_card_footer.dart';

/// Beautiful, professional flight card widget.
class FlightCard extends StatelessWidget {
  const FlightCard({
    super.key,
    required this.fareItinerary,
    this.onTap,
    this.animationDelay = Duration.zero,
  });

  final FareItinerary fareItinerary;
  final VoidCallback? onTap;
  final Duration animationDelay;

  @override
  Widget build(BuildContext context) {
    final firstSegment = fareItinerary
        .airItinerary
        .originDestinationOptions
        .firstOrNull
        ?.originDestinationOption
        .firstOrNull
        ?.flightSegment;

    if (firstSegment == null) {
      return const SizedBox.shrink();
    }

    final departureTime = DateTimeFormatter.parseIsoDateTime(
      firstSegment.departureDateTime,
    );
    final arrivalTime = DateTimeFormatter.parseIsoDateTime(
      firstSegment.arrivalDateTime,
    );

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.sm,
        ),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: AppColors.border, width: 1),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlightCardHeader(
                  airlineCode: firstSegment.marketingAirlineCode,
                  airlineName: firstSegment.marketingAirlineName,
                  flightNumber: firstSegment.flightNumber,
                  cabinClass: firstSegment.cabinClassText,
                ),
                const SizedBox(height: AppSpacing.lg),
                FlightCardRoute(
                  origin: firstSegment.departureAirportLocationCode,
                  destination: firstSegment.arrivalAirportLocationCode,
                  departureTime: departureTime,
                  arrivalTime: arrivalTime,
                  duration: firstSegment.journeyDuration,
                  stops:
                      fareItinerary
                          .airItinerary
                          .originDestinationOptions
                          .firstOrNull
                          ?.totalStops ??
                      0,
                ),
                const SizedBox(height: AppSpacing.lg),
                FlightCardFooter(
                  totalFare: fareItinerary
                      .airItineraryFareInfo
                      .itinTotalFares
                      .totalFare,
                  baggage: fareItinerary
                      .airItineraryFareInfo
                      .fareBreakdown
                      .firstOrNull
                      ?.baggage
                      .firstOrNull,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
