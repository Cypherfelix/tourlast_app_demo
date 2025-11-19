// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_baggage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicBaggage _$DynamicBaggageFromJson(Map<String, dynamic> json) =>
    DynamicBaggage(
      behavior: json['Behavior'] as String,
      isMultiSelect: json['IsMultiSelect'] as bool,
      services: (json['Services'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => ExtraService.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
    );

Map<String, dynamic> _$DynamicBaggageToJson(DynamicBaggage instance) =>
    <String, dynamic>{
      'Behavior': instance.behavior,
      'IsMultiSelect': instance.isMultiSelect,
      'Services': instance.services,
    };
