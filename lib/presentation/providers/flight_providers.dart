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
