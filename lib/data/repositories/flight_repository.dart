import '../models/flight/flight_response.dart';
import '../sources/local/json_data_source.dart';
import '../../core/errors/data_exception.dart';

/// Repository for flight data operations.
class FlightRepository {
  FlightRepository._();

  static FlightRepository? _instance;
  static FlightRepository get instance => _instance ??= FlightRepository._();

  FlightResponse? _cachedFlights;
  DateTime? _cacheTimestamp;
  static const Duration _cacheValidityDuration = Duration(hours: 1);

  /// Get all flights from JSON file.
  ///
  /// Returns cached data if available and still valid, otherwise loads from source.
  Future<FlightResponse> getFlights({bool forceRefresh = false}) async {
    // Return cached data if available and not expired
    if (!forceRefresh &&
        _cachedFlights != null &&
        _cacheTimestamp != null &&
        DateTime.now().difference(_cacheTimestamp!) < _cacheValidityDuration) {
      return _cachedFlights!;
    }

    try {
      final jsonData = await JsonDataSource.loadFlights();
      final response = FlightResponse.fromJson(jsonData);

      // Cache the result
      _cachedFlights = response;
      _cacheTimestamp = DateTime.now();

      return response;
    } on DataException {
      rethrow;
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack trace: $stackTrace');
      throw DataParsingException(
        'Failed to parse flight response: $e',
        stackTrace,
      );
    }
  }

  /// Clear the flight cache.
  void clearCache() {
    _cachedFlights = null;
    _cacheTimestamp = null;
  }

  /// Get flights for a specific search (filtered by origin/destination).
  ///
  /// This is a placeholder for future filtering logic.
  Future<FlightResponse> searchFlights({
    String? origin,
    String? destination,
    DateTime? departureDate,
  }) async {
    final flights = await getFlights();
    // TODO: Implement filtering logic in Story 5.4
    return flights;
  }
}
