import '../../../data/models/flight/fare_itinerary.dart';
import '../../../core/utils/date_time_formatter.dart';
import '../widgets/flights/filters/filter_models.dart';

/// Service for filtering flight itineraries based on filter criteria.
class FlightFilterService {
  FlightFilterService._();

  /// Filter flights based on the provided filters.
  static List<FareItinerary> filterFlights(
    List<FareItinerary> flights,
    FlightFilters filters,
  ) {
    if (filters == FlightFilters.empty()) {
      return flights;
    }

    return flights.where((flight) {
      // Airline filter
      if (filters.selectedAirlines.isNotEmpty) {
        final firstSegment = flight
            .airItinerary
            .originDestinationOptions
            .firstOrNull
            ?.originDestinationOption
            .firstOrNull
            ?.flightSegment;

        if (firstSegment == null) return false;

        final airlineCode = firstSegment.marketingAirlineCode;
        if (!filters.selectedAirlines.contains(airlineCode)) {
          return false;
        }
      }

      // Price filter
      if (filters.minPrice != null || filters.maxPrice != null) {
        final totalFare = flight.airItineraryFareInfo.itinTotalFares.totalFare;
        final price = totalFare.amountValue;

        if (filters.minPrice != null && price < filters.minPrice!) {
          return false;
        }
        if (filters.maxPrice != null && price > filters.maxPrice!) {
          return false;
        }
      }

      // Departure time filter
      if (filters.departureTimeRanges.isNotEmpty) {
        final firstSegment = flight
            .airItinerary
            .originDestinationOptions
            .firstOrNull
            ?.originDestinationOption
            .firstOrNull
            ?.flightSegment;

        if (firstSegment == null) return false;

        final departureDateTime = DateTimeFormatter.parseIsoDateTime(
          firstSegment.departureDateTime,
        );
        if (departureDateTime == null) return false;

        final hour = departureDateTime.hour;
        final matchesTimeRange = filters.departureTimeRanges.any(
          (range) => range.isInRange(hour),
        );

        if (!matchesTimeRange) {
          return false;
        }
      }

      // Cabin class filter
      if (filters.selectedCabins.isNotEmpty) {
        final firstSegment = flight
            .airItinerary
            .originDestinationOptions
            .firstOrNull
            ?.originDestinationOption
            .firstOrNull
            ?.flightSegment;

        if (firstSegment == null) return false;

        final cabinClass = firstSegment.cabinClassText;
        if (!filters.selectedCabins.contains(cabinClass)) {
          return false;
        }
      }

      // Stops filter
      if (filters.maxStops != null) {
        final totalStops =
            flight
                .airItinerary
                .originDestinationOptions
                .firstOrNull
                ?.totalStops ??
            0;

        if (filters.maxStops == 2) {
          // 2+ stops means 2 or more
          if (totalStops < 2) {
            return false;
          }
        } else if (totalStops != filters.maxStops) {
          return false;
        }
      }

      // Baggage filter
      if (filters.hasBaggage != null) {
        final fareBreakdown =
            flight.airItineraryFareInfo.fareBreakdown.firstOrNull;
        final baggageList = fareBreakdown?.baggage ?? [];

        // Check if any baggage exists (list is not empty)
        final hasBaggage = baggageList.isNotEmpty;

        if (filters.hasBaggage == true && !hasBaggage) {
          return false;
        }
        if (filters.hasBaggage == false && hasBaggage) {
          return false;
        }
      }

      return true;
    }).toList();
  }
}
