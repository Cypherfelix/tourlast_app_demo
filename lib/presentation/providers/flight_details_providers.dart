import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/flight/fare_itinerary.dart';

/// State model for flight details screen.
class FlightDetailsState {
  const FlightDetailsState({
    required this.fareItinerary,
    this.selectedServices = const {},
    this.scrollPosition = 0.0,
  });

  final FareItinerary? fareItinerary;
  final Map<String, int> selectedServices; // serviceId -> quantity
  final double scrollPosition;

  FlightDetailsState copyWith({
    FareItinerary? fareItinerary,
    Map<String, int>? selectedServices,
    double? scrollPosition,
    bool clearFareItinerary = false,
  }) {
    return FlightDetailsState(
      fareItinerary: clearFareItinerary
          ? null
          : (fareItinerary ?? this.fareItinerary),
      selectedServices: selectedServices ?? this.selectedServices,
      scrollPosition: scrollPosition ?? this.scrollPosition,
    );
  }
}

/// Provider for flight details state (preserves state across navigation).
final flightDetailsStateProvider =
    StateNotifierProvider.family<FlightDetailsStateNotifier, FlightDetailsState,
        String>(
  (ref, flightId) => FlightDetailsStateNotifier(),
);

/// State notifier for flight details.
class FlightDetailsStateNotifier extends StateNotifier<FlightDetailsState> {
  FlightDetailsStateNotifier() : super(_initialState);

  static const _initialState = FlightDetailsState(
    fareItinerary: null,
    selectedServices: {},
    scrollPosition: 0.0,
  );

  void initialize(FareItinerary fareItinerary) {
    state = FlightDetailsState(
      fareItinerary: fareItinerary,
      selectedServices: state.selectedServices,
      scrollPosition: state.scrollPosition,
    );
  }

  void updateServiceQuantity(String serviceId, int quantity) {
    final updatedServices = Map<String, int>.from(state.selectedServices);
    if (quantity <= 0) {
      updatedServices.remove(serviceId);
    } else {
      updatedServices[serviceId] = quantity;
    }
    state = state.copyWith(selectedServices: updatedServices);
  }

  void updateScrollPosition(double position) {
    state = state.copyWith(scrollPosition: position);
  }

  void clearServices() {
    state = state.copyWith(selectedServices: {});
  }

  /// Reset state completely (clears fareItinerary, services, and scroll position).
  void reset() {
    state = _initialState;
  }
}

/// Helper to generate unique flight ID for state management.
String generateFlightId(FareItinerary fareItinerary) {
  final firstSegment = fareItinerary
      .airItinerary
      .originDestinationOptions
      .firstOrNull
      ?.originDestinationOption
      .firstOrNull
      ?.flightSegment;

  if (firstSegment == null) {
    return fareItinerary.hashCode.toString();
  }

  return '${firstSegment.marketingAirlineCode}_${firstSegment.flightNumber}_${firstSegment.departureDateTime}_${fareItinerary.hashCode}';
}

