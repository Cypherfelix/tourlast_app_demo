import 'package:json_annotation/json_annotation.dart';

import 'operating_airline.dart';

part 'flight_segment.g.dart';

@JsonSerializable()
class FlightSegment {
  const FlightSegment({
    required this.arrivalAirportLocationCode,
    required this.arrivalDateTime,
    required this.cabinClassCode,
    required this.cabinClassText,
    required this.departureAirportLocationCode,
    required this.departureDateTime,
    required this.eticket,
    required this.journeyDuration,
    required this.flightNumber,
    required this.marketingAirlineCode,
    required this.marketingAirlineName,
    this.marriageGroup,
    this.mealCode,
    required this.operatingAirline,
  });

  @JsonKey(name: 'ArrivalAirportLocationCode')
  final String arrivalAirportLocationCode;

  @JsonKey(name: 'ArrivalDateTime')
  final String arrivalDateTime;

  @JsonKey(name: 'CabinClassCode')
  final String cabinClassCode;

  @JsonKey(name: 'CabinClassText')
  final String cabinClassText;

  @JsonKey(name: 'DepartureAirportLocationCode')
  final String departureAirportLocationCode;

  @JsonKey(name: 'DepartureDateTime')
  final String departureDateTime;

  @JsonKey(name: 'Eticket')
  final bool eticket;

  @JsonKey(name: 'JourneyDuration')
  final String journeyDuration;

  @JsonKey(name: 'FlightNumber')
  final String flightNumber;

  @JsonKey(name: 'MarketingAirlineCode')
  final String marketingAirlineCode;

  @JsonKey(name: 'MarketingAirlineName')
  final String marketingAirlineName;

  @JsonKey(name: 'MarriageGroup')
  final String? marriageGroup;

  @JsonKey(name: 'MealCode')
  final String? mealCode;

  @JsonKey(name: 'OperatingAirline')
  final OperatingAirline operatingAirline;

  factory FlightSegment.fromJson(Map<String, dynamic> json) =>
      _$FlightSegmentFromJson(json);
  Map<String, dynamic> toJson() => _$FlightSegmentToJson(this);
}
