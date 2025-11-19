// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlightResponse _$FlightResponseFromJson(Map<String, dynamic> json) =>
    FlightResponse(
      airSearchResponse: AirSearchResponse.fromJson(
          json['AirSearchResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FlightResponseToJson(FlightResponse instance) =>
    <String, dynamic>{
      'AirSearchResponse': instance.airSearchResponse,
    };

AirSearchResponse _$AirSearchResponseFromJson(Map<String, dynamic> json) =>
    AirSearchResponse(
      sessionId: json['session_id'] as String,
      airSearchResult: AirSearchResult.fromJson(
          json['AirSearchResult'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AirSearchResponseToJson(AirSearchResponse instance) =>
    <String, dynamic>{
      'session_id': instance.sessionId,
      'AirSearchResult': instance.airSearchResult,
    };
