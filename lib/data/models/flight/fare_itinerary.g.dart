// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fare_itinerary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FareItinerary _$FareItineraryFromJson(Map<String, dynamic> json) =>
    FareItinerary(
      directionInd: json['DirectionInd'] as String,
      airItineraryFareInfo: AirItineraryFareInfo.fromJson(
        json['AirItineraryFareInfo'] as Map<String, dynamic>,
      ),
      airItinerary: AirItinerary.fromJson(
        json['AirItinerary'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$FareItineraryToJson(FareItinerary instance) =>
    <String, dynamic>{
      'DirectionInd': instance.directionInd,
      'AirItineraryFareInfo': instance.airItineraryFareInfo,
      'AirItinerary': instance.airItinerary,
    };
