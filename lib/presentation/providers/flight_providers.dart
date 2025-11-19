import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/flight/fare_itinerary.dart';
import '../../../data/models/flight/flight_response.dart';
import '../../../data/providers/repository_providers.dart';

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
