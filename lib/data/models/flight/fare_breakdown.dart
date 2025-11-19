import 'package:json_annotation/json_annotation.dart';

import 'passenger_fare.dart';
import 'passenger_type_quantity.dart';
import 'penalty_details.dart';

part 'fare_breakdown.g.dart';

@JsonSerializable()
class FareBreakdown {
  const FareBreakdown({
    this.fareBasisCode,
    required this.baggage,
    required this.cabinBaggage,
    required this.passengerFare,
    required this.passengerTypeQuantity,
    required this.penaltyDetails,
  });

  @JsonKey(name: 'FareBasisCode')
  final String? fareBasisCode;

  @JsonKey(name: 'Baggage')
  final List<String> baggage;

  @JsonKey(name: 'CabinBaggage')
  final List<String> cabinBaggage;

  @JsonKey(name: 'PassengerFare')
  final PassengerFare passengerFare;

  @JsonKey(name: 'PassengerTypeQuantity')
  final PassengerTypeQuantity passengerTypeQuantity;

  @JsonKey(name: 'PenaltyDetails')
  final PenaltyDetails penaltyDetails;

  factory FareBreakdown.fromJson(Map<String, dynamic> json) =>
      _$FareBreakdownFromJson(json);
  Map<String, dynamic> toJson() => _$FareBreakdownToJson(this);
}
