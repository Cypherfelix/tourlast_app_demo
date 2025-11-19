// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passenger_fare.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PassengerFare _$PassengerFareFromJson(Map<String, dynamic> json) =>
    PassengerFare(
      baseFare: Money.fromJson(json['BaseFare'] as Map<String, dynamic>),
      equivFare: Money.fromJson(json['EquivFare'] as Map<String, dynamic>),
      serviceTax: Money.fromJson(json['ServiceTax'] as Map<String, dynamic>),
      surcharges: Money.fromJson(json['Surcharges'] as Map<String, dynamic>),
      taxes: (json['Taxes'] as List<dynamic>)
          .map((e) => Tax.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalFare: Money.fromJson(json['TotalFare'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PassengerFareToJson(PassengerFare instance) =>
    <String, dynamic>{
      'BaseFare': instance.baseFare,
      'EquivFare': instance.equivFare,
      'ServiceTax': instance.serviceTax,
      'Surcharges': instance.surcharges,
      'Taxes': instance.taxes,
      'TotalFare': instance.totalFare,
    };
