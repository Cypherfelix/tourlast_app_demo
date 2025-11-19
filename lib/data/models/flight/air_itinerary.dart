import 'package:json_annotation/json_annotation.dart';

import 'origin_destination_option.dart';

part 'air_itinerary.g.dart';

@JsonSerializable()
class AirItinerary {
  const AirItinerary({
    required this.originDestinationOptions,
    this.isPassportMandatory,
    this.sequenceNumber,
    required this.ticketType,
    required this.validatingAirlineCode,
  });

  @JsonKey(name: 'OriginDestinationOptions')
  final List<OriginDestinationOptions> originDestinationOptions;

  @JsonKey(name: 'IsPassportMandatory')
  final bool? isPassportMandatory;

  @JsonKey(name: 'SequenceNumber')
  final String? sequenceNumber;

  @JsonKey(name: 'TicketType')
  final String ticketType;

  @JsonKey(name: 'ValidatingAirlineCode')
  final String validatingAirlineCode;

  factory AirItinerary.fromJson(Map<String, dynamic> json) =>
      _$AirItineraryFromJson(json);
  Map<String, dynamic> toJson() => _$AirItineraryToJson(this);
}

@JsonSerializable()
class OriginDestinationOptions {
  const OriginDestinationOptions({
    required this.originDestinationOption,
    required this.totalStops,
  });

  @JsonKey(name: 'OriginDestinationOption')
  final List<OriginDestinationOption> originDestinationOption;

  @JsonKey(name: 'TotalStops')
  final int totalStops;

  factory OriginDestinationOptions.fromJson(Map<String, dynamic> json) =>
      _$OriginDestinationOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$OriginDestinationOptionsToJson(this);
}
