import 'package:json_annotation/json_annotation.dart';

part 'operating_airline.g.dart';

@JsonSerializable()
class OperatingAirline {
  const OperatingAirline({
    required this.code,
    required this.name,
    this.equipment,
    this.flightNumber,
  });

  @JsonKey(name: 'Code')
  final String code;

  @JsonKey(name: 'Name')
  final String name;

  @JsonKey(name: 'Equipment')
  final String? equipment;

  @JsonKey(name: 'FlightNumber')
  final String? flightNumber;

  factory OperatingAirline.fromJson(Map<String, dynamic> json) =>
      _$OperatingAirlineFromJson(json);
  Map<String, dynamic> toJson() => _$OperatingAirlineToJson(this);
}
