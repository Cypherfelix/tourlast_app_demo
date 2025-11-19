import 'package:json_annotation/json_annotation.dart';

part 'reservation_item.g.dart';

@JsonSerializable()
class ReservationItem {
  const ReservationItem({
    this.airEquipmentType,
    required this.airlinePNR,
    required this.arrivalAirportLocationCode,
    required this.arrivalDateTime,
    this.arrivalTerminal,
    required this.baggage,
    required this.cabinClassText,
    required this.departureAirportLocationCode,
    required this.departureDateTime,
    this.departureTerminal,
    required this.flightNumber,
    required this.itemRPH,
    required this.journeyDuration,
    required this.marketingAirlineCode,
    required this.numberInParty,
    required this.operatingAirlineCode,
    required this.resBookDesigCode,
    required this.stopQuantity,
  });

  @JsonKey(name: 'AirEquipmentType')
  final String? airEquipmentType;

  @JsonKey(name: 'AirlinePNR')
  final String airlinePNR;

  @JsonKey(name: 'ArrivalAirportLocationCode')
  final String arrivalAirportLocationCode;

  @JsonKey(name: 'ArrivalDateTime')
  final String arrivalDateTime;

  @JsonKey(name: 'ArrivalTerminal')
  final String? arrivalTerminal;

  @JsonKey(name: 'Baggage')
  final String baggage;

  @JsonKey(name: 'CabinClassText')
  final String cabinClassText;

  @JsonKey(name: 'DepartureAirportLocationCode')
  final String departureAirportLocationCode;

  @JsonKey(name: 'DepartureDateTime')
  final String departureDateTime;

  @JsonKey(name: 'DepartureTerminal')
  final String? departureTerminal;

  @JsonKey(name: 'FlightNumber')
  final String flightNumber;

  @JsonKey(name: 'ItemRPH')
  final int itemRPH;

  @JsonKey(name: 'JourneyDuration')
  final String journeyDuration;

  @JsonKey(name: 'MarketingAirlineCode')
  final String marketingAirlineCode;

  @JsonKey(name: 'NumberInParty')
  final int numberInParty;

  @JsonKey(name: 'OperatingAirlineCode')
  final String operatingAirlineCode;

  @JsonKey(name: 'ResBookDesigCode')
  final String resBookDesigCode;

  @JsonKey(name: 'StopQuantity')
  final int stopQuantity;

  factory ReservationItem.fromJson(Map<String, dynamic> json) =>
      _$ReservationItemFromJson(json);
  Map<String, dynamic> toJson() => _$ReservationItemToJson(this);
}
