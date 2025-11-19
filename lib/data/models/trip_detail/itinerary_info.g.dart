// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itinerary_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItineraryInfo _$ItineraryInfoFromJson(
  Map<String, dynamic> json,
) => ItineraryInfo(
  customerInfos: (json['CustomerInfos'] as List<dynamic>)
      .map((e) => CustomerInfoWrapper.fromJson(e as Map<String, dynamic>))
      .toList(),
  itineraryPricing: ItineraryPricing.fromJson(
    json['ItineraryPricing'] as Map<String, dynamic>,
  ),
  reservationItems: (json['ReservationItems'] as List<dynamic>)
      .map((e) => ReservationItemWrapper.fromJson(e as Map<String, dynamic>))
      .toList(),
  tripDetailsPtcFareBreakdowns:
      (json['TripDetailsPTC_FareBreakdowns'] as List<dynamic>)
          .map(
            (e) => TripDetailsPtcFareBreakdownWrapper.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
  extraServices: ExtraServices.fromJson(
    json['ExtraServices'] as Map<String, dynamic>,
  ),
  bookingNotes: json['BookingNotes'] as List<dynamic>,
);

Map<String, dynamic> _$ItineraryInfoToJson(ItineraryInfo instance) =>
    <String, dynamic>{
      'CustomerInfos': instance.customerInfos,
      'ItineraryPricing': instance.itineraryPricing,
      'ReservationItems': instance.reservationItems,
      'TripDetailsPTC_FareBreakdowns': instance.tripDetailsPtcFareBreakdowns,
      'ExtraServices': instance.extraServices,
      'BookingNotes': instance.bookingNotes,
    };

CustomerInfoWrapper _$CustomerInfoWrapperFromJson(Map<String, dynamic> json) =>
    CustomerInfoWrapper(
      customerInfo: CustomerInfo.fromJson(
        json['CustomerInfo'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$CustomerInfoWrapperToJson(
  CustomerInfoWrapper instance,
) => <String, dynamic>{'CustomerInfo': instance.customerInfo};

ReservationItemWrapper _$ReservationItemWrapperFromJson(
  Map<String, dynamic> json,
) => ReservationItemWrapper(
  reservationItem: ReservationItem.fromJson(
    json['ReservationItem'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$ReservationItemWrapperToJson(
  ReservationItemWrapper instance,
) => <String, dynamic>{'ReservationItem': instance.reservationItem};

TripDetailsPtcFareBreakdownWrapper _$TripDetailsPtcFareBreakdownWrapperFromJson(
  Map<String, dynamic> json,
) => TripDetailsPtcFareBreakdownWrapper(
  tripDetailsPtcFareBreakdown: TripDetailsPtcFareBreakdown.fromJson(
    json['TripDetailsPTC_FareBreakdown'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$TripDetailsPtcFareBreakdownWrapperToJson(
  TripDetailsPtcFareBreakdownWrapper instance,
) => <String, dynamic>{
  'TripDetailsPTC_FareBreakdown': instance.tripDetailsPtcFareBreakdown,
};

ExtraServices _$ExtraServicesFromJson(Map<String, dynamic> json) =>
    ExtraServices(
      services: (json['Services'] as List<dynamic>)
          .map((e) => TripServiceWrapper.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExtraServicesToJson(ExtraServices instance) =>
    <String, dynamic>{'Services': instance.services};

TripServiceWrapper _$TripServiceWrapperFromJson(Map<String, dynamic> json) =>
    TripServiceWrapper(
      service: TripService.fromJson(json['Service'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TripServiceWrapperToJson(TripServiceWrapper instance) =>
    <String, dynamic>{'Service': instance.service};
