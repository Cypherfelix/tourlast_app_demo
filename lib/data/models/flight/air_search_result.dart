import 'package:json_annotation/json_annotation.dart';

import 'fare_itinerary.dart';

part 'air_search_result.g.dart';

@JsonSerializable()
class AirSearchResult {
  const AirSearchResult({required this.fareItineraries});

  @JsonKey(name: 'FareItineraries')
  final List<FareItineraryWrapper> fareItineraries;

  factory AirSearchResult.fromJson(Map<String, dynamic> json) =>
      _$AirSearchResultFromJson(json);
  Map<String, dynamic> toJson() => _$AirSearchResultToJson(this);
}

@JsonSerializable()
class FareItineraryWrapper {
  const FareItineraryWrapper({required this.fareItinerary});

  @JsonKey(name: 'FareItinerary')
  final FareItinerary fareItinerary;

  factory FareItineraryWrapper.fromJson(Map<String, dynamic> json) =>
      _$FareItineraryWrapperFromJson(json);
  Map<String, dynamic> toJson() => _$FareItineraryWrapperToJson(this);
}
