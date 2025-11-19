import 'package:json_annotation/json_annotation.dart';

import '../flight/passenger_type_quantity.dart';
import 'trip_details_passenger_fare.dart';

part 'trip_details_ptc_fare_breakdown.g.dart';

@JsonSerializable()
class TripDetailsPtcFareBreakdown {
  const TripDetailsPtcFareBreakdown({
    required this.passengerTypeQuantity,
    required this.tripDetailsPassengerFare,
  });

  @JsonKey(name: 'PassengerTypeQuantity')
  final PassengerTypeQuantity passengerTypeQuantity;

  @JsonKey(name: 'TripDetailsPassengerFare')
  final TripDetailsPassengerFare tripDetailsPassengerFare;

  factory TripDetailsPtcFareBreakdown.fromJson(Map<String, dynamic> json) =>
      _$TripDetailsPtcFareBreakdownFromJson(json);
  Map<String, dynamic> toJson() => _$TripDetailsPtcFareBreakdownToJson(this);
}
