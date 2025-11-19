import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/repositories.dart';

/// Provider for FlightRepository.
final flightRepositoryProvider = Provider<FlightRepository>((ref) {
  return FlightRepository.instance;
});

/// Provider for AirlineRepository.
final airlineRepositoryProvider = Provider<AirlineRepository>((ref) {
  return AirlineRepository.instance;
});

/// Provider for ExtraServiceRepository.
final extraServiceRepositoryProvider = Provider<ExtraServiceRepository>((ref) {
  return ExtraServiceRepository.instance;
});

/// Provider for TripDetailRepository.
final tripDetailRepositoryProvider = Provider<TripDetailRepository>((ref) {
  return TripDetailRepository.instance;
});
