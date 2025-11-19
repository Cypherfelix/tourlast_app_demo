// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationItem _$ReservationItemFromJson(Map<String, dynamic> json) =>
    ReservationItem(
      airEquipmentType: json['AirEquipmentType'] as String?,
      airlinePNR: json['AirlinePNR'] as String,
      arrivalAirportLocationCode: json['ArrivalAirportLocationCode'] as String,
      arrivalDateTime: json['ArrivalDateTime'] as String,
      arrivalTerminal: json['ArrivalTerminal'] as String?,
      baggage: json['Baggage'] as String,
      cabinClassText: json['CabinClassText'] as String,
      departureAirportLocationCode:
          json['DepartureAirportLocationCode'] as String,
      departureDateTime: json['DepartureDateTime'] as String,
      departureTerminal: json['DepartureTerminal'] as String?,
      flightNumber: json['FlightNumber'] as String,
      itemRPH: (json['ItemRPH'] as num).toInt(),
      journeyDuration: json['JourneyDuration'] as String,
      marketingAirlineCode: json['MarketingAirlineCode'] as String,
      numberInParty: (json['NumberInParty'] as num).toInt(),
      operatingAirlineCode: json['OperatingAirlineCode'] as String,
      resBookDesigCode: json['ResBookDesigCode'] as String,
      stopQuantity: (json['StopQuantity'] as num).toInt(),
    );

Map<String, dynamic> _$ReservationItemToJson(ReservationItem instance) =>
    <String, dynamic>{
      'AirEquipmentType': instance.airEquipmentType,
      'AirlinePNR': instance.airlinePNR,
      'ArrivalAirportLocationCode': instance.arrivalAirportLocationCode,
      'ArrivalDateTime': instance.arrivalDateTime,
      'ArrivalTerminal': instance.arrivalTerminal,
      'Baggage': instance.baggage,
      'CabinClassText': instance.cabinClassText,
      'DepartureAirportLocationCode': instance.departureAirportLocationCode,
      'DepartureDateTime': instance.departureDateTime,
      'DepartureTerminal': instance.departureTerminal,
      'FlightNumber': instance.flightNumber,
      'ItemRPH': instance.itemRPH,
      'JourneyDuration': instance.journeyDuration,
      'MarketingAirlineCode': instance.marketingAirlineCode,
      'NumberInParty': instance.numberInParty,
      'OperatingAirlineCode': instance.operatingAirlineCode,
      'ResBookDesigCode': instance.resBookDesigCode,
      'StopQuantity': instance.stopQuantity,
    };
