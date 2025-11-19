// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_services_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtraServicesData _$ExtraServicesDataFromJson(Map<String, dynamic> json) =>
    ExtraServicesData(
      dynamicBaggage: (json['DynamicBaggage'] as List<dynamic>)
          .map((e) => DynamicBaggage.fromJson(e as Map<String, dynamic>))
          .toList(),
      dynamicMeal: json['DynamicMeal'] as List<dynamic>,
      dynamicSeat: json['DynamicSeat'] as List<dynamic>,
    );

Map<String, dynamic> _$ExtraServicesDataToJson(ExtraServicesData instance) =>
    <String, dynamic>{
      'DynamicBaggage': instance.dynamicBaggage,
      'DynamicMeal': instance.dynamicMeal,
      'DynamicSeat': instance.dynamicSeat,
    };
