import 'package:json_annotation/json_annotation.dart';

import 'trip_details_result.dart';

part 'trip_details_response.g.dart';

@JsonSerializable()
class TripDetailsResponse {
  const TripDetailsResponse({required this.tripDetailsResponse});

  @JsonKey(name: 'TripDetailsResponse')
  final TripDetailsResponseData tripDetailsResponse;

  factory TripDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$TripDetailsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TripDetailsResponseToJson(this);
}

@JsonSerializable()
class TripDetailsResponseData {
  const TripDetailsResponseData({required this.tripDetailsResult});

  @JsonKey(name: 'TripDetailsResult')
  final TripDetailsResult tripDetailsResult;

  factory TripDetailsResponseData.fromJson(Map<String, dynamic> json) =>
      _$TripDetailsResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$TripDetailsResponseDataToJson(this);
}
