import 'package:json_annotation/json_annotation.dart';

import 'air_search_result.dart';

part 'flight_response.g.dart';

@JsonSerializable()
class FlightResponse {
  const FlightResponse({required this.airSearchResponse});

  @JsonKey(name: 'AirSearchResponse')
  final AirSearchResponse airSearchResponse;

  factory FlightResponse.fromJson(Map<String, dynamic> json) =>
      _$FlightResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FlightResponseToJson(this);
}

@JsonSerializable()
class AirSearchResponse {
  const AirSearchResponse({
    required this.sessionId,
    required this.airSearchResult,
  });

  @JsonKey(name: 'session_id')
  final String sessionId;

  @JsonKey(name: 'AirSearchResult')
  final AirSearchResult airSearchResult;

  factory AirSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$AirSearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AirSearchResponseToJson(this);
}
