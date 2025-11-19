/// Models for flight filters.
class FlightFilters {
  const FlightFilters({
    this.selectedAirlines = const [],
    this.minPrice,
    this.maxPrice,
    this.departureTimeRanges = const [],
    this.selectedCabins = const [],
    this.maxStops,
    this.hasBaggage,
  });

  final List<String> selectedAirlines;
  final double? minPrice;
  final double? maxPrice;
  final List<DepartureTimeRange> departureTimeRanges;
  final List<String> selectedCabins;
  final int? maxStops;
  final bool? hasBaggage;

  factory FlightFilters.empty() => const FlightFilters();

  FlightFilters copyWith({
    List<String>? selectedAirlines,
    double? minPrice,
    double? maxPrice,
    Object? minPriceNull = _sentinel,
    Object? maxPriceNull = _sentinel,
    List<DepartureTimeRange>? departureTimeRanges,
    List<String>? selectedCabins,
    int? maxStops,
    Object? maxStopsNull = _sentinel,
    bool? hasBaggage,
    Object? hasBaggageNull = _sentinel,
  }) {
    return FlightFilters(
      selectedAirlines: selectedAirlines ?? this.selectedAirlines,
      minPrice: minPriceNull == _sentinel ? null : (minPrice ?? this.minPrice),
      maxPrice: maxPriceNull == _sentinel ? null : (maxPrice ?? this.maxPrice),
      departureTimeRanges: departureTimeRanges ?? this.departureTimeRanges,
      selectedCabins: selectedCabins ?? this.selectedCabins,
      maxStops: maxStopsNull == _sentinel ? null : (maxStops ?? this.maxStops),
      hasBaggage: hasBaggageNull == _sentinel
          ? null
          : (hasBaggage ?? this.hasBaggage),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FlightFilters &&
        other.selectedAirlines.toString() == selectedAirlines.toString() &&
        other.minPrice == minPrice &&
        other.maxPrice == maxPrice &&
        other.departureTimeRanges.toString() ==
            departureTimeRanges.toString() &&
        other.selectedCabins.toString() == selectedCabins.toString() &&
        other.maxStops == maxStops &&
        other.hasBaggage == hasBaggage;
  }

  @override
  int get hashCode {
    return Object.hash(
      selectedAirlines,
      minPrice,
      maxPrice,
      departureTimeRanges,
      selectedCabins,
      maxStops,
      hasBaggage,
    );
  }
}

const _sentinel = Object();

/// Departure time range options.
enum DepartureTimeRange {
  earlyMorning, // 00:00 - 06:00
  morning, // 06:00 - 12:00
  afternoon, // 12:00 - 18:00
  evening, // 18:00 - 24:00
}

extension DepartureTimeRangeExtension on DepartureTimeRange {
  String get label {
    switch (this) {
      case DepartureTimeRange.earlyMorning:
        return 'Early Morning';
      case DepartureTimeRange.morning:
        return 'Morning';
      case DepartureTimeRange.afternoon:
        return 'Afternoon';
      case DepartureTimeRange.evening:
        return 'Evening';
    }
  }

  String get timeRange {
    switch (this) {
      case DepartureTimeRange.earlyMorning:
        return '00:00 - 06:00';
      case DepartureTimeRange.morning:
        return '06:00 - 12:00';
      case DepartureTimeRange.afternoon:
        return '12:00 - 18:00';
      case DepartureTimeRange.evening:
        return '18:00 - 24:00';
    }
  }

  bool isInRange(int hour) {
    switch (this) {
      case DepartureTimeRange.earlyMorning:
        return hour >= 0 && hour < 6;
      case DepartureTimeRange.morning:
        return hour >= 6 && hour < 12;
      case DepartureTimeRange.afternoon:
        return hour >= 12 && hour < 18;
      case DepartureTimeRange.evening:
        return hour >= 18 && hour < 24;
    }
  }
}
