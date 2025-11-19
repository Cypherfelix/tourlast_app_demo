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
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) => Transform.translate(
        offset: Offset(0, 12 * (1 - value)),
        child: Opacity(opacity: value, child: child),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.xs,
        ),
        elevation: 0,
        color: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(
            color: AppColors.border.withValues(alpha: 0.8),
            width: 1,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlightCardHeader(
                  airlineCode: firstSegment.marketingAirlineCode,
                  airlineName: firstSegment.marketingAirlineName,
                  flightNumber: firstSegment.flightNumber,
                  cabinClass: firstSegment.cabinClassText,
                ),
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
