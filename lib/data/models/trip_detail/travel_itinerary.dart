import 'package:json_annotation/json_annotation.dart';

import 'itinerary_info.dart';

part 'travel_itinerary.g.dart';

@JsonSerializable()
class TravelItinerary {
  const TravelItinerary({
    required this.bookingStatus,
    required this.crossBorderIndicator,
    required this.destination,
    required this.fareType,
    required this.isCommissionable,
    required this.isMOFare,
    required this.itineraryInfo,
    required this.uniqueID,
    required this.origin,
    required this.ticketStatus,
  });

  @JsonKey(name: 'BookingStatus')
  final String bookingStatus;

  @JsonKey(name: 'CrossBorderIndicator')
  final bool crossBorderIndicator;

  @JsonKey(name: 'Destination')
  final String destination;

  @JsonKey(name: 'FareType')
  final String fareType;

  @JsonKey(name: 'IsCommissionable')
  final bool isCommissionable;

  @JsonKey(name: 'IsMOFare')
  final bool isMOFare;

  @JsonKey(name: 'ItineraryInfo')
  final ItineraryInfo itineraryInfo;

  @JsonKey(name: 'UniqueID')
  final String uniqueID;

  @JsonKey(name: 'Origin')
  final String origin;

  @JsonKey(name: 'TicketStatus')
  final String ticketStatus;

  factory TravelItinerary.fromJson(Map<String, dynamic> json) =>
      _$TravelItineraryFromJson(json);
  Map<String, dynamic> toJson() => _$TravelItineraryToJson(this);
}
