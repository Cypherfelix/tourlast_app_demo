// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_details_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripDetailsResult _$TripDetailsResultFromJson(Map<String, dynamic> json) =>
    TripDetailsResult(
      success: json['Success'] as String,
      target: json['Target'] as String,
      travelItinerary: TravelItinerary.fromJson(
        json['TravelItinerary'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$TripDetailsResultToJson(TripDetailsResult instance) =>
    <String, dynamic>{
      'Success': instance.success,
      'Target': instance.target,
      'TravelItinerary': instance.travelItinerary,
    };
