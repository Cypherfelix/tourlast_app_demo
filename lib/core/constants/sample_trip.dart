import 'package:intl/intl.dart';

/// Immutable sample trip data used to seed the experience.
class SampleTrip {
  SampleTrip._();

  static const String origin = 'AMS';
  static const String originCity = 'Amsterdam';
  static const String destination = 'LON';
  static const String destinationCity = 'London';
  static const String journeyType = 'One-way';

  static final DateTime departureDate = DateTime(2025, 12, 21);
  static String get formattedDate =>
      DateFormat('EEE, d MMM yyyy').format(departureDate);

  static const int adults = 2;
  static const int children = 1;
  static const int infants = 1;
  static const String cabinClass = 'Economy';
  static const String currency = 'USD';
}
