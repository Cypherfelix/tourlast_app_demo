// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_segment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlightSegment _$FlightSegmentFromJson(Map<String, dynamic> json) =>
    FlightSegment(
      arrivalAirportLocationCode: json['ArrivalAirportLocationCode'] as String,
      arrivalDateTime: json['ArrivalDateTime'] as String,
      cabinClassCode: json['CabinClassCode'] as String,
      cabinClassText: json['CabinClassText'] as String,
      departureAirportLocationCode:
          json['DepartureAirportLocationCode'] as String,
      departureDateTime: json['DepartureDateTime'] as String,
      eticket: json['Eticket'] as bool,
      journeyDuration: json['JourneyDuration'] as String,
      flightNumber: json['FlightNumber'] as String,
      marketingAirlineCode: json['MarketingAirlineCode'] as String,
      marketingAirlineName: json['MarketingAirlineName'] as String,
      marriageGroup: json['MarriageGroup'] as String?,
      mealCode: json['MealCode'] as String?,
      operatingAirline: OperatingAirline.fromJson(
          json['OperatingAirline'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FlightSegmentToJson(FlightSegment instance) =>
    <String, dynamic>{
      'ArrivalAirportLocationCode': instance.arrivalAirportLocationCode,
      'ArrivalDateTime': instance.arrivalDateTime,
      'CabinClassCode': instance.cabinClassCode,
      'CabinClassText': instance.cabinClassText,
      'DepartureAirportLocationCode': instance.departureAirportLocationCode,
      'DepartureDateTime': instance.departureDateTime,
      'Eticket': instance.eticket,
      'JourneyDuration': instance.journeyDuration,
      'FlightNumber': instance.flightNumber,
      'MarketingAirlineCode': instance.marketingAirlineCode,
      'MarketingAirlineName': instance.marketingAirlineName,
      'MarriageGroup': instance.marriageGroup,
      'MealCode': instance.mealCode,
      'OperatingAirline': instance.operatingAirline,
    };
