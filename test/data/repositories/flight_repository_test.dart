import 'package:flutter_test/flutter_test.dart';
import 'package:tourlast_app/data/repositories/flight_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FlightRepository Tests', () {
    late FlightRepository repository;

    setUp(() {
      repository = FlightRepository.instance;
      repository.clearCache();
    });

    test('should load flights from JSON file', () async {
      final flights = await repository.getFlights();

      expect(flights, isNotNull);
      expect(flights.airSearchResponse.sessionId, isNotEmpty);
      expect(
        flights.airSearchResponse.airSearchResult.fareItineraries,
        isNotEmpty,
      );
    });

    test('should cache flights data', () async {
      // First call
      final flights1 = await repository.getFlights();
      final timestamp1 = DateTime.now();

      // Second call should use cache
      final flights2 = await repository.getFlights();
      final timestamp2 = DateTime.now();

      expect(flights1, equals(flights2));
      // Should be very fast if using cache
      expect(timestamp2.difference(timestamp1).inMilliseconds, lessThan(100));
    });

    test('should refresh when forceRefresh is true', () async {
      // First call
      await repository.getFlights();

      // Force refresh
      final flights = await repository.getFlights(forceRefresh: true);

      expect(flights, isNotNull);
      expect(
        flights.airSearchResponse.airSearchResult.fareItineraries,
        isNotEmpty,
      );
    });

    test('should handle flights with all required fields', () async {
      final flights = await repository.getFlights();

      for (final wrapper
          in flights.airSearchResponse.airSearchResult.fareItineraries) {
        final itinerary = wrapper.fareItinerary;

        // Verify required fields exist
        expect(itinerary.directionInd, isNotEmpty);
        expect(itinerary.airItineraryFareInfo, isNotNull);
        expect(itinerary.airItinerary, isNotNull);

        // Verify fare info
        expect(
          itinerary.airItineraryFareInfo.itinTotalFares.totalFare.amount,
          isNotEmpty,
        );

        // Verify itinerary has routes
        expect(itinerary.airItinerary.originDestinationOptions, isNotEmpty);
      }
    });
  });
}
