// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fare_breakdown.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FareBreakdown _$FareBreakdownFromJson(Map<String, dynamic> json) =>
    FareBreakdown(
      fareBasisCode: json['FareBasisCode'] as String?,
      baggage:
          (json['Baggage'] as List<dynamic>).map((e) => e as String).toList(),
      cabinBaggage: (json['CabinBaggage'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      passengerFare:
          PassengerFare.fromJson(json['PassengerFare'] as Map<String, dynamic>),
      passengerTypeQuantity: PassengerTypeQuantity.fromJson(
          json['PassengerTypeQuantity'] as Map<String, dynamic>),
      penaltyDetails: PenaltyDetails.fromJson(
          json['PenaltyDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FareBreakdownToJson(FareBreakdown instance) =>
    <String, dynamic>{
      'FareBasisCode': instance.fareBasisCode,
      'Baggage': instance.baggage,
      'CabinBaggage': instance.cabinBaggage,
      'PassengerFare': instance.passengerFare,
      'PassengerTypeQuantity': instance.passengerTypeQuantity,
      'PenaltyDetails': instance.penaltyDetails,
    };
