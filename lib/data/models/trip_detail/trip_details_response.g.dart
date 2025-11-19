// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripDetailsResponse _$TripDetailsResponseFromJson(Map<String, dynamic> json) =>
    TripDetailsResponse(
      tripDetailsResponse: TripDetailsResponseData.fromJson(
          json['TripDetailsResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TripDetailsResponseToJson(
        TripDetailsResponse instance) =>
    <String, dynamic>{
      'TripDetailsResponse': instance.tripDetailsResponse,
    };

TripDetailsResponseData _$TripDetailsResponseDataFromJson(
        Map<String, dynamic> json) =>
    TripDetailsResponseData(
      tripDetailsResult: TripDetailsResult.fromJson(
          json['TripDetailsResult'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TripDetailsResponseDataToJson(
        TripDetailsResponseData instance) =>
    <String, dynamic>{
      'TripDetailsResult': instance.tripDetailsResult,
    };
