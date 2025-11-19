import 'package:json_annotation/json_annotation.dart';

import 'fare_breakdown.dart';
import 'itin_total_fares.dart';

part 'air_itinerary_fare_info.g.dart';

@JsonSerializable()
class AirItineraryFareInfo {
  const AirItineraryFareInfo({
    required this.divideInPartyIndicator,
    required this.fareSourceCode,
    required this.fareInfos,
    required this.fareType,
    required this.resultIndex,
    required this.isRefundable,
    required this.itinTotalFares,
    required this.fareBreakdown,
    required this.splitItinerary,
  });

  @JsonKey(name: 'DivideInPartyIndicator')
  final String divideInPartyIndicator;

  @JsonKey(name: 'FareSourceCode')
  final String fareSourceCode;

  @JsonKey(name: 'FareInfos')
  final List<dynamic> fareInfos;

  @JsonKey(name: 'FareType')
  final String fareType;

  @JsonKey(name: 'ResultIndex')
  final String resultIndex;

  @JsonKey(name: 'IsRefundable')
  final String isRefundable;

  @JsonKey(name: 'ItinTotalFares')
  final ItinTotalFares itinTotalFares;

  @JsonKey(name: 'FareBreakdown')
  final List<FareBreakdown> fareBreakdown;

  @JsonKey(name: 'SplitItinerary')
  final bool splitItinerary;

  factory AirItineraryFareInfo.fromJson(Map<String, dynamic> json) =>
      _$AirItineraryFareInfoFromJson(json);
  Map<String, dynamic> toJson() => _$AirItineraryFareInfoToJson(this);
}
