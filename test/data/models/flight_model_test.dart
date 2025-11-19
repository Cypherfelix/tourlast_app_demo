import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tourlast_app/data/models/common/money.dart';
import 'package:tourlast_app/data/models/flight/flight_response.dart';

void main() {
  group('Flight Model Tests', () {
    test('should parse flights.json successfully', () {
      // Load the JSON file
      final file = File('lib/data/json-files/flights.json');
      final jsonString = file.readAsStringSync();
      final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;

      // Parse the response
      expect(
        () => FlightResponse.fromJson(jsonData),
        returnsNormally,
        reason: 'FlightResponse should parse without errors',
      );

      final response = FlightResponse.fromJson(jsonData);

      // Verify structure
      expect(response.airSearchResponse, isNotNull);
      expect(
        response.airSearchResponse.airSearchResult.fareItineraries,
        isNotEmpty,
        reason: 'Should have at least one fare itinerary',
      );

      // Verify each fare itinerary
      for (final wrapper
          in response.airSearchResponse.airSearchResult.fareItineraries) {
        final itinerary = wrapper.fareItinerary;
        expect(itinerary.directionInd, isNotEmpty);
        expect(itinerary.airItineraryFareInfo, isNotNull);
        expect(itinerary.airItinerary, isNotNull);
        expect(itinerary.airItinerary.originDestinationOptions, isNotEmpty);
      }
    });

    test('should handle null values in Money fields', () {
      final moneyJson = {
        'Amount': '100.00',
        'CurrencyCode': 'USD',
        'DecimalPlaces': null,
      };

      // This should not throw
      expect(() => Money.fromJson(moneyJson), returnsNormally);
    });

    test('should handle missing DecimalPlaces in Money', () {
      final moneyJson = {'Amount': '100.00', 'CurrencyCode': 'USD'};

      // This should not throw
      expect(() => Money.fromJson(moneyJson), returnsNormally);
    });
  });
}
