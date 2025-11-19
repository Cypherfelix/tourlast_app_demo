import 'package:json_annotation/json_annotation.dart';

import 'customer_info.dart';
import 'itinerary_pricing.dart';
import 'reservation_item.dart';
import 'trip_details_ptc_fare_breakdown.dart';
import 'trip_service.dart';

part 'itinerary_info.g.dart';

@JsonSerializable()
class ItineraryInfo {
  const ItineraryInfo({
    required this.customerInfos,
    required this.itineraryPricing,
    required this.reservationItems,
    required this.tripDetailsPtcFareBreakdowns,
    required this.extraServices,
    required this.bookingNotes,
  });

  @JsonKey(name: 'CustomerInfos')
  final List<CustomerInfoWrapper> customerInfos;

  @JsonKey(name: 'ItineraryPricing')
  final ItineraryPricing itineraryPricing;

  @JsonKey(name: 'ReservationItems')
  final List<ReservationItemWrapper> reservationItems;

  @JsonKey(name: 'TripDetailsPTC_FareBreakdowns')
  final List<TripDetailsPtcFareBreakdownWrapper> tripDetailsPtcFareBreakdowns;

  @JsonKey(name: 'ExtraServices')
  final ExtraServices extraServices;

  @JsonKey(name: 'BookingNotes')
  final List<dynamic> bookingNotes;

  factory ItineraryInfo.fromJson(Map<String, dynamic> json) =>
      _$ItineraryInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ItineraryInfoToJson(this);
}

@JsonSerializable()
class CustomerInfoWrapper {
  const CustomerInfoWrapper({required this.customerInfo});

  @JsonKey(name: 'CustomerInfo')
  final CustomerInfo customerInfo;

  factory CustomerInfoWrapper.fromJson(Map<String, dynamic> json) =>
      _$CustomerInfoWrapperFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerInfoWrapperToJson(this);
}

@JsonSerializable()
class ReservationItemWrapper {
  const ReservationItemWrapper({required this.reservationItem});

  @JsonKey(name: 'ReservationItem')
  final ReservationItem reservationItem;

  factory ReservationItemWrapper.fromJson(Map<String, dynamic> json) =>
      _$ReservationItemWrapperFromJson(json);
  Map<String, dynamic> toJson() => _$ReservationItemWrapperToJson(this);
}

@JsonSerializable()
class TripDetailsPtcFareBreakdownWrapper {
  const TripDetailsPtcFareBreakdownWrapper({
    required this.tripDetailsPtcFareBreakdown,
  });

  @JsonKey(name: 'TripDetailsPTC_FareBreakdown')
  final TripDetailsPtcFareBreakdown tripDetailsPtcFareBreakdown;

  factory TripDetailsPtcFareBreakdownWrapper.fromJson(
    Map<String, dynamic> json,
  ) => _$TripDetailsPtcFareBreakdownWrapperFromJson(json);
  Map<String, dynamic> toJson() =>
      _$TripDetailsPtcFareBreakdownWrapperToJson(this);
}

@JsonSerializable()
class ExtraServices {
  const ExtraServices({required this.services});

  @JsonKey(name: 'Services')
  final List<TripServiceWrapper> services;

  factory ExtraServices.fromJson(Map<String, dynamic> json) =>
      _$ExtraServicesFromJson(json);
  Map<String, dynamic> toJson() => _$ExtraServicesToJson(this);
}

@JsonSerializable()
class TripServiceWrapper {
  const TripServiceWrapper({required this.service});

  @JsonKey(name: 'Service')
  final TripService service;

  factory TripServiceWrapper.fromJson(Map<String, dynamic> json) =>
      _$TripServiceWrapperFromJson(json);
  Map<String, dynamic> toJson() => _$TripServiceWrapperToJson(this);
}
