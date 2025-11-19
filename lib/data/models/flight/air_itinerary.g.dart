// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'air_itinerary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirItinerary _$AirItineraryFromJson(Map<String, dynamic> json) => AirItinerary(
  originDestinationOptions: (json['OriginDestinationOptions'] as List<dynamic>)
      .map((e) => OriginDestinationOptions.fromJson(e as Map<String, dynamic>))
      .toList(),
  isPassportMandatory: json['IsPassportMandatory'] as bool?,
  sequenceNumber: json['SequenceNumber'] as String?,
  ticketType: json['TicketType'] as String,
  validatingAirlineCode: json['ValidatingAirlineCode'] as String,
);

Map<String, dynamic> _$AirItineraryToJson(AirItinerary instance) =>
    <String, dynamic>{
      'OriginDestinationOptions': instance.originDestinationOptions,
      'IsPassportMandatory': instance.isPassportMandatory,
      'SequenceNumber': instance.sequenceNumber,
      'TicketType': instance.ticketType,
      'ValidatingAirlineCode': instance.validatingAirlineCode,
    };

OriginDestinationOptions _$OriginDestinationOptionsFromJson(
  Map<String, dynamic> json,
) => OriginDestinationOptions(
  originDestinationOption: (json['OriginDestinationOption'] as List<dynamic>)
      .map((e) => OriginDestinationOption.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalStops: (json['TotalStops'] as num).toInt(),
);

Map<String, dynamic> _$OriginDestinationOptionsToJson(
  OriginDestinationOptions instance,
) => <String, dynamic>{
  'OriginDestinationOption': instance.originDestinationOption,
  'TotalStops': instance.totalStops,
};
