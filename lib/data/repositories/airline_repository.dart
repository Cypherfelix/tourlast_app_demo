import '../models/airline/airline.dart';
import '../sources/local/json_data_source.dart';
import '../../core/errors/data_exception.dart';

/// Repository for airline data operations.
class AirlineRepository {
  AirlineRepository._();

  static AirlineRepository? _instance;
  static AirlineRepository get instance => _instance ??= AirlineRepository._();

  List<Airline>? _cachedAirlines;
  DateTime? _cacheTimestamp;
  static const Duration _cacheValidityDuration = Duration(hours: 24);

  /// Get all airlines from JSON file.
  ///
  /// Returns cached data if available and still valid, otherwise loads from source.
  Future<List<Airline>> getAirlines({bool forceRefresh = false}) async {
    // Return cached data if available and not expired
    if (!forceRefresh &&
        _cachedAirlines != null &&
        _cacheTimestamp != null &&
        DateTime.now().difference(_cacheTimestamp!) < _cacheValidityDuration) {
      return _cachedAirlines!;
    }

    try {
      final jsonData = await JsonDataSource.loadAirlines();
      final airlines = jsonData
          .map((json) => Airline.fromJson(json as Map<String, dynamic>))
          .toList();

      // Cache the result
      _cachedAirlines = airlines;
      _cacheTimestamp = DateTime.now();

      return airlines;
    } on DataException {
      rethrow;
    } catch (e, stackTrace) {
      throw DataParsingException('Failed to parse airlines: $e', stackTrace);
    }
  }

  /// Get airline by code.
  Future<Airline?> getAirlineByCode(String code) async {
    final airlines = await getAirlines();
    try {
      return airlines.firstWhere((airline) => airline.airLineCode == code);
    } catch (_) {
      return null;
    }
  }

  /// Search airlines by name (case-insensitive).
  Future<List<Airline>> searchAirlines(String query) async {
    final airlines = await getAirlines();
    final lowerQuery = query.toLowerCase();
    return airlines
        .where(
          (airline) =>
              airline.airLineName.toLowerCase().contains(lowerQuery) ||
              airline.airLineCode.toLowerCase().contains(lowerQuery),
        )
        .toList();
  }

  /// Clear the airline cache.
  void clearCache() {
    _cachedAirlines = null;
    _cacheTimestamp = null;
  }
}
