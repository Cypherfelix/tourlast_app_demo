import 'package:json_annotation/json_annotation.dart';

import 'air_itinerary.dart';
import 'air_itinerary_fare_info.dart';

part 'fare_itinerary.g.dart';

@JsonSerializable()
class FareItinerary {
  const FareItinerary({
    required this.directionInd,
    required this.airItineraryFareInfo,
    required this.airItinerary,
  });

  @JsonKey(name: 'DirectionInd')
  final String directionInd;

  @JsonKey(name: 'AirItineraryFareInfo')
  final AirItineraryFareInfo airItineraryFareInfo;

  @JsonKey(name: 'AirItinerary')
  final AirItinerary airItinerary;

  factory FareItinerary.fromJson(Map<String, dynamic> json) =>
      _$FareItineraryFromJson(json);
  Map<String, dynamic> toJson() => _$FareItineraryToJson(this);
}
