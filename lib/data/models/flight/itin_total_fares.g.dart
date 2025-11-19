// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itin_total_fares.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItinTotalFares _$ItinTotalFaresFromJson(Map<String, dynamic> json) =>
    ItinTotalFares(
      baseFare: Money.fromJson(json['BaseFare'] as Map<String, dynamic>),
      equivFare: Money.fromJson(json['EquivFare'] as Map<String, dynamic>),
      serviceTax: Money.fromJson(json['ServiceTax'] as Map<String, dynamic>),
      totalTax: Money.fromJson(json['TotalTax'] as Map<String, dynamic>),
      totalFare: Money.fromJson(json['TotalFare'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItinTotalFaresToJson(ItinTotalFares instance) =>
    <String, dynamic>{
      'BaseFare': instance.baseFare,
      'EquivFare': instance.equivFare,
      'ServiceTax': instance.serviceTax,
      'TotalTax': instance.totalTax,
      'TotalFare': instance.totalFare,
    };
