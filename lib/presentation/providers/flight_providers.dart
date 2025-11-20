import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/flight/fare_itinerary.dart';
import '../../../data/models/flight/flight_response.dart';
import '../../../data/providers/repository_providers.dart';
import '../utils/flight_filter_service.dart';
import '../widgets/flights/filters/filter_models.dart';

/// Provider that fetches flights data.
final flightsProvider = FutureProvider<FlightResponse>((ref) async {
  final repository = ref.watch(flightRepositoryProvider);
  return repository.getFlights();
});

/// Provider for flight list items (extracted from response).
final flightListProvider = Provider<AsyncValue<List<FareItinerary>>>((ref) {
  final flightsAsync = ref.watch(flightsProvider);
  return flightsAsync.when(
    data: (response) {
      final fareItineraries = response
          .airSearchResponse
          .airSearchResult
          .fareItineraries
          .map((wrapper) => wrapper.fareItinerary)
          .toList();
      return AsyncValue.data(fareItineraries);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
  );
});

/// Provider for filtered flight list items.
final filteredFlightListProvider =
    Provider.family<AsyncValue<List<FareItinerary>>, FlightFilters>(
  (ref, filters) {
    final flightsAsync = ref.watch(flightListProvider);
    return flightsAsync.when(
      data: (flights) {
        final filteredFlights =
            FlightFilterService.filterFlights(flights, filters);
        return AsyncValue.data(filteredFlights);
      },
      loading: () => const AsyncValue.loading(),
      error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
    );
  },
);

/// Provider that extracts unique cabin classes from flights data.
final cabinClassesProvider = Provider<AsyncValue<List<String>>>((ref) {
  final flightsAsync = ref.watch(flightListProvider);
  return flightsAsync.when(
    data: (flights) {
      final cabinClasses = <String>{};
      
      for (final flight in flights) {
        for (final option in flight.airItinerary.originDestinationOptions) {
          for (final originDest in option.originDestinationOption) {
            final cabinClass = originDest.flightSegment.cabinClassText;
            if (cabinClass.isNotEmpty) {
              cabinClasses.add(cabinClass);
            }
          }
        }
      }
      
      // Sort cabin classes in a logical order
      final sortedCabins = cabinClasses.toList()
        ..sort((a, b) {
          // Custom sorting: BASIC, BASIC FLEX, PLUS, MAX, then alphabetically
          final order = ['BASIC', 'BASIC FLEX', 'PLUS', 'MAX'];
          final aIndex = order.indexOf(a);
          final bIndex = order.indexOf(b);
          
          if (aIndex != -1 && bIndex != -1) {
            return aIndex.compareTo(bIndex);
          }
          if (aIndex != -1) return -1;
          if (bIndex != -1) return 1;
          return a.compareTo(b);
        });
      
      return AsyncValue.data(sortedCabins);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
  );
});
