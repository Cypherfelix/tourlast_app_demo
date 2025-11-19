import '../models/trip_detail/trip_details_response.dart';
import '../sources/local/json_data_source.dart';
import '../../core/errors/data_exception.dart';

/// Repository for trip details data operations.
class TripDetailRepository {
  TripDetailRepository._();

  static TripDetailRepository? _instance;
  static TripDetailRepository get instance =>
      _instance ??= TripDetailRepository._();

  TripDetailsResponse? _cachedTripDetails;
  DateTime? _cacheTimestamp;
  static const Duration _cacheValidityDuration = Duration(hours: 1);

  /// Get trip details from JSON file.
  ///
  /// Returns cached data if available and still valid, otherwise loads from source.
  Future<TripDetailsResponse> getTripDetails({
    bool forceRefresh = false,
  }) async {
    // Return cached data if available and not expired
    if (!forceRefresh &&
        _cachedTripDetails != null &&
        _cacheTimestamp != null &&
        DateTime.now().difference(_cacheTimestamp!) < _cacheValidityDuration) {
      return _cachedTripDetails!;
    }

    try {
      final jsonData = await JsonDataSource.loadTripDetails();
      final response = TripDetailsResponse.fromJson(jsonData);

      // Cache the result
      _cachedTripDetails = response;
      _cacheTimestamp = DateTime.now();

      return response;
    } on DataException {
      rethrow;
    } catch (e, stackTrace) {
      throw DataParsingException(
        'Failed to parse trip details response: $e',
        stackTrace,
      );
    }
  }

  /// Clear the trip details cache.
  void clearCache() {
    _cachedTripDetails = null;
    _cacheTimestamp = null;
  }
}
