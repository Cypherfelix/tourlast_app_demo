// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtraService _$ExtraServiceFromJson(Map<String, dynamic> json) => ExtraService(
  serviceId: json['ServiceId'] as String,
  checkInType: json['CheckInType'] as String,
  description: json['Description'] as String,
  fareDescription: json['FareDescription'] as String,
  isMandatory: json['IsMandatory'] as bool,
  minimumQuantity: (json['MinimumQuantity'] as num).toInt(),
  maximumQuantity: (json['MaximumQuantity'] as num).toInt(),
  serviceCost: Money.fromJson(json['ServiceCost'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ExtraServiceToJson(ExtraService instance) =>
    <String, dynamic>{
      'ServiceId': instance.serviceId,
      'CheckInType': instance.checkInType,
      'Description': instance.description,
      'FareDescription': instance.fareDescription,
      'IsMandatory': instance.isMandatory,
      'MinimumQuantity': instance.minimumQuantity,
      'MaximumQuantity': instance.maximumQuantity,
      'ServiceCost': instance.serviceCost,
    };
