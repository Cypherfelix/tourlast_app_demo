import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Service to preload JSON assets for faster access later.
class AssetLoader {
  AssetLoader._();

  static const List<String> _jsonAssets = [
    'lib/data/json-files/flights.json',
    'lib/data/json-files/airline-list.json',
    'lib/data/json-files/extra-services.json',
    'lib/data/json-files/trip-details.json',
  ];

  /// Preload all JSON assets in the background.
  static Future<void> preloadAssets() async {
    try {
      await Future.wait(
        _jsonAssets.map((asset) => rootBundle.loadString(asset)),
      );
    } catch (e) {
      // Log error but don't fail - assets will load on-demand if needed
      debugPrint('Warning: Failed to preload some assets: $e');
    }
  }
}
