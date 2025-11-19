// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stop_quantity_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StopQuantityInfo _$StopQuantityInfoFromJson(Map<String, dynamic> json) =>
    StopQuantityInfo(
      arrivalDateTime: json['ArrivalDateTime'] as String?,
      departureDateTime: json['DepartureDateTime'] as String?,
      duration: json['Duration'] as String?,
      locationCode: json['LocationCode'] as String?,
    );

Map<String, dynamic> _$StopQuantityInfoToJson(StopQuantityInfo instance) =>
    <String, dynamic>{
      'ArrivalDateTime': instance.arrivalDateTime,
      'DepartureDateTime': instance.departureDateTime,
      'Duration': instance.duration,
      'LocationCode': instance.locationCode,
    };
