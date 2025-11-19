import 'package:flutter_test/flutter_test.dart';
import 'package:tourlast_app/data/repositories/trip_detail_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TripDetailRepository Tests', () {
    late TripDetailRepository repository;

    setUp(() {
      repository = TripDetailRepository.instance;
      repository.clearCache();
    });

    test('should load trip details from JSON file', () async {
      final tripDetails = await repository.getTripDetails();

      expect(tripDetails, isNotNull);
      expect(tripDetails.tripDetailsResponse.tripDetailsResult.success, 'true');
    });

    test('should cache trip details data', () async {
      final details1 = await repository.getTripDetails();
      final timestamp1 = DateTime.now();

      final details2 = await repository.getTripDetails();
      final timestamp2 = DateTime.now();

      expect(details1, equals(details2));
      expect(timestamp2.difference(timestamp1).inMilliseconds, lessThan(100));
    });

    test('should refresh when forceRefresh is true', () async {
      await repository.getTripDetails();
      final details = await repository.getTripDetails(forceRefresh: true);

      expect(details, isNotNull);
      expect(details.tripDetailsResponse.tripDetailsResult.success, 'true');
    });

    test('should have valid travel itinerary', () async {
      final details = await repository.getTripDetails();

      final itinerary =
          details.tripDetailsResponse.tripDetailsResult.travelItinerary;

      expect(itinerary.bookingStatus, isNotEmpty);
      expect(itinerary.origin, isNotEmpty);
      expect(itinerary.destination, isNotEmpty);
      expect(itinerary.uniqueID, isNotEmpty);
    });

    test('should have customer infos', () async {
      final details = await repository.getTripDetails();

      final customerInfos = details
          .tripDetailsResponse
          .tripDetailsResult
          .travelItinerary
          .itineraryInfo
          .customerInfos;

      expect(customerInfos, isNotEmpty);
    });

    test('should have reservation items', () async {
      final details = await repository.getTripDetails();

      final reservationItems = details
          .tripDetailsResponse
          .tripDetailsResult
          .travelItinerary
          .itineraryInfo
          .reservationItems;

      expect(reservationItems, isNotEmpty);
    });

    test('should clear cache', () {
      expect(() => repository.clearCache(), returnsNormally);
    });
  });
}
