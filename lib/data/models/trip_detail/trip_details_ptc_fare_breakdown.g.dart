// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_details_ptc_fare_breakdown.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripDetailsPtcFareBreakdown _$TripDetailsPtcFareBreakdownFromJson(
  Map<String, dynamic> json,
) => TripDetailsPtcFareBreakdown(
  passengerTypeQuantity: PassengerTypeQuantity.fromJson(
    json['PassengerTypeQuantity'] as Map<String, dynamic>,
  ),
  tripDetailsPassengerFare: TripDetailsPassengerFare.fromJson(
    json['TripDetailsPassengerFare'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$TripDetailsPtcFareBreakdownToJson(
  TripDetailsPtcFareBreakdown instance,
) => <String, dynamic>{
  'PassengerTypeQuantity': instance.passengerTypeQuantity,
  'TripDetailsPassengerFare': instance.tripDetailsPassengerFare,
};
