// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_details_passenger_fare.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripDetailsPassengerFare _$TripDetailsPassengerFareFromJson(
        Map<String, dynamic> json) =>
    TripDetailsPassengerFare(
      equiFare: Money.fromJson(json['EquiFare'] as Map<String, dynamic>),
      serviceTax: Money.fromJson(json['ServiceTax'] as Map<String, dynamic>),
      tax: Money.fromJson(json['Tax'] as Map<String, dynamic>),
      totalFare: Money.fromJson(json['TotalFare'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TripDetailsPassengerFareToJson(
        TripDetailsPassengerFare instance) =>
    <String, dynamic>{
      'EquiFare': instance.equiFare,
      'ServiceTax': instance.serviceTax,
      'Tax': instance.tax,
      'TotalFare': instance.totalFare,
    };
