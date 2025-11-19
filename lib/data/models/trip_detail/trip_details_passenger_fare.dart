import 'package:json_annotation/json_annotation.dart';

import '../common/money.dart';

part 'trip_details_passenger_fare.g.dart';

@JsonSerializable()
class TripDetailsPassengerFare {
  const TripDetailsPassengerFare({
    required this.equiFare,
    required this.serviceTax,
    required this.tax,
    required this.totalFare,
  });

  @JsonKey(name: 'EquiFare')
  final Money equiFare;

  @JsonKey(name: 'ServiceTax')
  final Money serviceTax;

  @JsonKey(name: 'Tax')
  final Money tax;

  @JsonKey(name: 'TotalFare')
  final Money totalFare;

  factory TripDetailsPassengerFare.fromJson(Map<String, dynamic> json) =>
      _$TripDetailsPassengerFareFromJson(json);
  Map<String, dynamic> toJson() => _$TripDetailsPassengerFareToJson(this);
}
