import 'package:json_annotation/json_annotation.dart';

part 'stop_quantity_info.g.dart';

@JsonSerializable()
class StopQuantityInfo {
  const StopQuantityInfo({
    this.arrivalDateTime,
    this.departureDateTime,
    this.duration,
    this.locationCode,
  });

  @JsonKey(name: 'ArrivalDateTime')
  final String? arrivalDateTime;

  @JsonKey(name: 'DepartureDateTime')
  final String? departureDateTime;

  @JsonKey(name: 'Duration')
  final String? duration;

  @JsonKey(name: 'LocationCode')
  final String? locationCode;

  factory StopQuantityInfo.fromJson(Map<String, dynamic> json) =>
      _$StopQuantityInfoFromJson(json);
  Map<String, dynamic> toJson() => _$StopQuantityInfoToJson(this);
}
