// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airline.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Airline _$AirlineFromJson(Map<String, dynamic> json) => Airline(
  airLineCode: json['AirLineCode'] as String,
  airLineName: json['AirLineName'] as String,
  airLineLogo: json['AirLineLogo'] as String,
);

Map<String, dynamic> _$AirlineToJson(Airline instance) => <String, dynamic>{
  'AirLineCode': instance.airLineCode,
  'AirLineName': instance.airLineName,
  'AirLineLogo': instance.airLineLogo,
};
