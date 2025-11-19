// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'origin_destination_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OriginDestinationOption _$OriginDestinationOptionFromJson(
        Map<String, dynamic> json) =>
    OriginDestinationOption(
      flightSegment:
          FlightSegment.fromJson(json['FlightSegment'] as Map<String, dynamic>),
      resBookDesigCode: json['ResBookDesigCode'] as String?,
      resBookDesigText: json['ResBookDesigText'] as String?,
      seatsRemaining: json['SeatsRemaining'] == null
          ? null
          : SeatsRemaining.fromJson(
              json['SeatsRemaining'] as Map<String, dynamic>),
      stopQuantity: (json['StopQuantity'] as num).toInt(),
      stopQuantityInfo: json['StopQuantityInfo'] == null
          ? null
          : StopQuantityInfo.fromJson(
              json['StopQuantityInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OriginDestinationOptionToJson(
        OriginDestinationOption instance) =>
    <String, dynamic>{
      'FlightSegment': instance.flightSegment,
      'ResBookDesigCode': instance.resBookDesigCode,
      'ResBookDesigText': instance.resBookDesigText,
      'SeatsRemaining': instance.seatsRemaining,
      'StopQuantity': instance.stopQuantity,
      'StopQuantityInfo': instance.stopQuantityInfo,
    };
