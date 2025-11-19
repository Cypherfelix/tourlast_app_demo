import '../models/extra_service/extra_services_response.dart';
import '../sources/local/json_data_source.dart';
import '../../core/errors/data_exception.dart';

/// Repository for extra services data operations.
class ExtraServiceRepository {
  ExtraServiceRepository._();

  static ExtraServiceRepository? _instance;
  static ExtraServiceRepository get instance =>
      _instance ??= ExtraServiceRepository._();

  ExtraServicesResponse? _cachedServices;
  DateTime? _cacheTimestamp;
  static const Duration _cacheValidityDuration = Duration(hours: 1);

  /// Get extra services from JSON file.
  ///
  /// Returns cached data if available and still valid, otherwise loads from source.
  Future<ExtraServicesResponse> getExtraServices({
    bool forceRefresh = false,
  }) async {
    // Return cached data if available and not expired
    if (!forceRefresh &&
        _cachedServices != null &&
        _cacheTimestamp != null &&
        DateTime.now().difference(_cacheTimestamp!) < _cacheValidityDuration) {
      return _cachedServices!;
    }

    try {
      final jsonData = await JsonDataSource.loadExtraServices();
      final response = ExtraServicesResponse.fromJson(jsonData);

      // Cache the result
      _cachedServices = response;
      _cacheTimestamp = DateTime.now();

      return response;
    } on DataException {
      rethrow;
    } catch (e, stackTrace) {
      throw DataParsingException(
        'Failed to parse extra services response: $e',
        stackTrace,
      );
    }
  }

  /// Clear the extra services cache.
  void clearCache() {
    _cachedServices = null;
    _cacheTimestamp = null;
  }
}
