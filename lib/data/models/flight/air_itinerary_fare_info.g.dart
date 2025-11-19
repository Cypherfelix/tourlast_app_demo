// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'air_itinerary_fare_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirItineraryFareInfo _$AirItineraryFareInfoFromJson(
  Map<String, dynamic> json,
) => AirItineraryFareInfo(
  divideInPartyIndicator: json['DivideInPartyIndicator'] as String,
  fareSourceCode: json['FareSourceCode'] as String,
  fareInfos: json['FareInfos'] as List<dynamic>,
  fareType: json['FareType'] as String,
  resultIndex: json['ResultIndex'] as String,
  isRefundable: json['IsRefundable'] as String,
  itinTotalFares: ItinTotalFares.fromJson(
    json['ItinTotalFares'] as Map<String, dynamic>,
  ),
  fareBreakdown: (json['FareBreakdown'] as List<dynamic>)
      .map((e) => FareBreakdown.fromJson(e as Map<String, dynamic>))
      .toList(),
  splitItinerary: json['SplitItinerary'] as bool,
);

Map<String, dynamic> _$AirItineraryFareInfoToJson(
  AirItineraryFareInfo instance,
) => <String, dynamic>{
  'DivideInPartyIndicator': instance.divideInPartyIndicator,
  'FareSourceCode': instance.fareSourceCode,
  'FareInfos': instance.fareInfos,
  'FareType': instance.fareType,
  'ResultIndex': instance.resultIndex,
  'IsRefundable': instance.isRefundable,
  'ItinTotalFares': instance.itinTotalFares,
  'FareBreakdown': instance.fareBreakdown,
  'SplitItinerary': instance.splitItinerary,
};
