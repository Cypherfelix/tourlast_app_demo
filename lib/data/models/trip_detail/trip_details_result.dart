import 'package:json_annotation/json_annotation.dart';

import 'travel_itinerary.dart';

part 'trip_details_result.g.dart';

@JsonSerializable()
class TripDetailsResult {
  const TripDetailsResult({
    required this.success,
    required this.target,
    required this.travelItinerary,
  });

  @JsonKey(name: 'Success')
  final String success;

  @JsonKey(name: 'Target')
  final String target;

  @JsonKey(name: 'TravelItinerary')
  final TravelItinerary travelItinerary;

  factory TripDetailsResult.fromJson(Map<String, dynamic> json) =>
      _$TripDetailsResultFromJson(json);
  Map<String, dynamic> toJson() => _$TripDetailsResultToJson(this);
}
