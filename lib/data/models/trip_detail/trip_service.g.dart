// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripService _$TripServiceFromJson(Map<String, dynamic> json) => TripService(
  behavior: json['Behavior'] as String,
  checkInType: json['CheckInType'] as String,
  description: json['Description'] as String,
  flightDesignator: json['FlightDesignator'] as String?,
  isMandatory: json['IsMandatory'] as bool,
  relation: json['Relation'] as String?,
  serviceCost: Money.fromJson(json['ServiceCost'] as Map<String, dynamic>),
  serviceId: json['ServiceId'] as String,
  type: json['Type'] as String,
);

Map<String, dynamic> _$TripServiceToJson(TripService instance) =>
    <String, dynamic>{
      'Behavior': instance.behavior,
      'CheckInType': instance.checkInType,
      'Description': instance.description,
      'FlightDesignator': instance.flightDesignator,
      'IsMandatory': instance.isMandatory,
      'Relation': instance.relation,
      'ServiceCost': instance.serviceCost,
      'ServiceId': instance.serviceId,
      'Type': instance.type,
    };
