// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_services_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtraServicesResponse _$ExtraServicesResponseFromJson(
        Map<String, dynamic> json) =>
    ExtraServicesResponse(
      extraServicesResponse: ExtraServicesResponseData.fromJson(
          json['ExtraServicesResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExtraServicesResponseToJson(
        ExtraServicesResponse instance) =>
    <String, dynamic>{
      'ExtraServicesResponse': instance.extraServicesResponse,
    };

ExtraServicesResponseData _$ExtraServicesResponseDataFromJson(
        Map<String, dynamic> json) =>
    ExtraServicesResponseData(
      extraServicesResult: ExtraServicesResult.fromJson(
          json['ExtraServicesResult'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExtraServicesResponseDataToJson(
        ExtraServicesResponseData instance) =>
    <String, dynamic>{
      'ExtraServicesResult': instance.extraServicesResult,
    };
