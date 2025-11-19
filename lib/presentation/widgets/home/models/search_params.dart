import '../models/trip_type.dart';

class SearchParams {
  const SearchParams({
    required this.tripType,
    required this.origin,
    required this.destination,
    required this.departureDate,
    this.returnDate,
    required this.adults,
    required this.children,
    required this.infants,
    required this.cabinClass,
    required this.currency,
  });

  final TripType tripType;
  final String origin;
  final String destination;
  final DateTime departureDate;
  final DateTime? returnDate;
  final int adults;
  final int children;
  final int infants;
  final String cabinClass;
  final String currency;
}
