import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../../core/errors/data_exception.dart';

/// Data source for reading JSON files from assets.
class JsonDataSource {
  JsonDataSource._();

  static const String _flightsPath = 'lib/data/json-files/flights.json';
  static const String _airlinesPath = 'lib/data/json-files/airline-list.json';
  static const String _extraServicesPath =
      'lib/data/json-files/extra-services.json';
  static const String _tripDetailsPath =
      'lib/data/json-files/trip-details.json';

  /// Load and parse flights JSON file.
  static Future<Map<String, dynamic>> loadFlights() async {
    try {
      final jsonString = await rootBundle.loadString(_flightsPath);
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } on FormatException catch (e) {
      throw DataParsingException('Failed to parse flights JSON: ${e.message}');
    } catch (e, stackTrace) {
      throw DataSourceException('Failed to load flights data: $e', stackTrace);
    }
  }

  /// Load and parse airlines JSON file.
  static Future<List<dynamic>> loadAirlines() async {
    try {
      final jsonString = await rootBundle.loadString(_airlinesPath);
      return jsonDecode(jsonString) as List<dynamic>;
    } on FormatException catch (e) {
      throw DataParsingException('Failed to parse airlines JSON: ${e.message}');
    } catch (e, stackTrace) {
      throw DataSourceException('Failed to load airlines data: $e', stackTrace);
    }
  }

  /// Load and parse extra services JSON file.
  static Future<Map<String, dynamic>> loadExtraServices() async {
    try {
      final jsonString = await rootBundle.loadString(_extraServicesPath);
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } on FormatException catch (e) {
      throw DataParsingException(
        'Failed to parse extra services JSON: ${e.message}',
      );
    } catch (e, stackTrace) {
      throw DataSourceException(
        'Failed to load extra services data: $e',
        stackTrace,
      );
    }
  }

  /// Load and parse trip details JSON file.
  static Future<Map<String, dynamic>> loadTripDetails() async {
    try {
      final jsonString = await rootBundle.loadString(_tripDetailsPath);
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } on FormatException catch (e) {
      throw DataParsingException(
        'Failed to parse trip details JSON: ${e.message}',
      );
    } catch (e, stackTrace) {
      throw DataSourceException(
        'Failed to load trip details data: $e',
        stackTrace,
      );
    }
  }
}
