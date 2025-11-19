import 'package:json_annotation/json_annotation.dart';

part 'airline.g.dart';

@JsonSerializable()
class Airline {
  const Airline({
    required this.airLineCode,
    required this.airLineName,
    required this.airLineLogo,
  });

  @JsonKey(name: 'AirLineCode')
  final String airLineCode;

  @JsonKey(name: 'AirLineName')
  final String airLineName;

  @JsonKey(name: 'AirLineLogo')
  final String airLineLogo;

  factory Airline.fromJson(Map<String, dynamic> json) =>
      _$AirlineFromJson(json);
  Map<String, dynamic> toJson() => _$AirlineToJson(this);
}
