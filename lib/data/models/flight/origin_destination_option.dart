import 'package:json_annotation/json_annotation.dart';

import 'flight_segment.dart';
import 'seats_remaining.dart';
import 'stop_quantity_info.dart';

part 'origin_destination_option.g.dart';

@JsonSerializable()
class OriginDestinationOption {
  const OriginDestinationOption({
    required this.flightSegment,
    this.resBookDesigCode,
    this.resBookDesigText,
    this.seatsRemaining,
    required this.stopQuantity,
    this.stopQuantityInfo,
  });

  @JsonKey(name: 'FlightSegment')
  final FlightSegment flightSegment;

  @JsonKey(name: 'ResBookDesigCode')
  final String? resBookDesigCode;

  @JsonKey(name: 'ResBookDesigText')
  final String? resBookDesigText;

  @JsonKey(name: 'SeatsRemaining')
  final SeatsRemaining? seatsRemaining;

  @JsonKey(name: 'StopQuantity')
  final int stopQuantity;

  @JsonKey(name: 'StopQuantityInfo')
  final StopQuantityInfo? stopQuantityInfo;

  factory OriginDestinationOption.fromJson(Map<String, dynamic> json) =>
      _$OriginDestinationOptionFromJson(json);
  Map<String, dynamic> toJson() => _$OriginDestinationOptionToJson(this);
}
