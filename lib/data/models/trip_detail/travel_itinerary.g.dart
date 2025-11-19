// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'travel_itinerary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TravelItinerary _$TravelItineraryFromJson(Map<String, dynamic> json) =>
    TravelItinerary(
      bookingStatus: json['BookingStatus'] as String,
      crossBorderIndicator: json['CrossBorderIndicator'] as bool,
      destination: json['Destination'] as String,
      fareType: json['FareType'] as String,
      isCommissionable: json['IsCommissionable'] as bool,
      isMOFare: json['IsMOFare'] as bool,
      itineraryInfo:
          ItineraryInfo.fromJson(json['ItineraryInfo'] as Map<String, dynamic>),
      uniqueID: json['UniqueID'] as String,
      origin: json['Origin'] as String,
      ticketStatus: json['TicketStatus'] as String,
    );

Map<String, dynamic> _$TravelItineraryToJson(TravelItinerary instance) =>
    <String, dynamic>{
      'BookingStatus': instance.bookingStatus,
      'CrossBorderIndicator': instance.crossBorderIndicator,
      'Destination': instance.destination,
      'FareType': instance.fareType,
      'IsCommissionable': instance.isCommissionable,
      'IsMOFare': instance.isMOFare,
      'ItineraryInfo': instance.itineraryInfo,
      'UniqueID': instance.uniqueID,
      'Origin': instance.origin,
      'TicketStatus': instance.ticketStatus,
    };
