// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operating_airline.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperatingAirline _$OperatingAirlineFromJson(Map<String, dynamic> json) =>
    OperatingAirline(
      code: json['Code'] as String,
      name: json['Name'] as String,
      equipment: json['Equipment'] as String?,
      flightNumber: json['FlightNumber'] as String?,
    );

Map<String, dynamic> _$OperatingAirlineToJson(OperatingAirline instance) =>
    <String, dynamic>{
      'Code': instance.code,
      'Name': instance.name,
      'Equipment': instance.equipment,
      'FlightNumber': instance.flightNumber,
    };
