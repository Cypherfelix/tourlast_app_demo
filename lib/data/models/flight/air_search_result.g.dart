// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'air_search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirSearchResult _$AirSearchResultFromJson(Map<String, dynamic> json) =>
    AirSearchResult(
      fareItineraries: (json['FareItineraries'] as List<dynamic>)
          .map((e) => FareItineraryWrapper.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AirSearchResultToJson(AirSearchResult instance) =>
    <String, dynamic>{'FareItineraries': instance.fareItineraries};

FareItineraryWrapper _$FareItineraryWrapperFromJson(
  Map<String, dynamic> json,
) => FareItineraryWrapper(
  fareItinerary: FareItinerary.fromJson(
    json['FareItinerary'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$FareItineraryWrapperToJson(
  FareItineraryWrapper instance,
) => <String, dynamic>{'FareItinerary': instance.fareItinerary};
