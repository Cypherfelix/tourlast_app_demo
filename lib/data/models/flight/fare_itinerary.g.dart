// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fare_itinerary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FareItinerary _$FareItineraryFromJson(Map<String, dynamic> json) =>
    FareItinerary(
      directionInd: FareItinerary._stringFromJson(json['DirectionInd']),
      airItineraryFareInfo: FareItinerary._airItineraryFareInfoFromJson(
          json['AirItineraryFareInfo']),
      airItinerary: FareItinerary._airItineraryFromJson(json['AirItinerary']),
    );

Map<String, dynamic> _$FareItineraryToJson(FareItinerary instance) =>
    <String, dynamic>{
      'DirectionInd': instance.directionInd,
      'AirItineraryFareInfo': instance.airItineraryFareInfo,
      'AirItinerary': instance.airItinerary,
    };
