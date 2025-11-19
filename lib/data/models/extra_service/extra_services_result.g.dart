// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_services_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtraServicesResult _$ExtraServicesResultFromJson(Map<String, dynamic> json) =>
    ExtraServicesResult(
      success: json['success'] as bool,
      extraServicesData: ExtraServicesData.fromJson(
        json['ExtraServicesData'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$ExtraServicesResultToJson(
  ExtraServicesResult instance,
) => <String, dynamic>{
  'success': instance.success,
  'ExtraServicesData': instance.extraServicesData,
};
