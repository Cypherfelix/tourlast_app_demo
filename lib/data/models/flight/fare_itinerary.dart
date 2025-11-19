import 'package:json_annotation/json_annotation.dart';

import 'air_itinerary.dart';
import 'air_itinerary_fare_info.dart';

part 'fare_itinerary.g.dart';

@JsonSerializable()
class FareItinerary {
  const FareItinerary({
    required this.directionInd,
    required this.airItineraryFareInfo,
    required this.airItinerary,
  });

  @JsonKey(name: 'DirectionInd', fromJson: _stringFromJson)
  final String directionInd;

  @JsonKey(
    name: 'AirItineraryFareInfo',
    fromJson: _airItineraryFareInfoFromJson,
  )
  final AirItineraryFareInfo airItineraryFareInfo;

  @JsonKey(name: 'AirItinerary', fromJson: _airItineraryFromJson)
  final AirItinerary airItinerary;

  static String _stringFromJson(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }

  static AirItineraryFareInfo _airItineraryFareInfoFromJson(dynamic value) {
    if (value == null) {
      throw const FormatException(
        'AirItineraryFareInfo cannot be null in FareItinerary',
      );
    }
    return AirItineraryFareInfo.fromJson(value as Map<String, dynamic>);
  }

  static AirItinerary _airItineraryFromJson(dynamic value) {
    // The JSON structure has AirItinerary fields directly in FareItinerary
    // So we need to construct AirItinerary from the parent JSON
    if (value == null) {
      // If AirItinerary key doesn't exist, we'll construct it from the parent
      // This will be handled in the custom fromJson
      throw const FormatException(
        'AirItinerary fields are missing in FareItinerary',
      );
    }
    return AirItinerary.fromJson(value as Map<String, dynamic>);
  }

  factory FareItinerary.fromJson(Map<String, dynamic> json) {
    // The JSON has AirItinerary fields directly in FareItinerary
    // We need to extract them and create the AirItinerary object
    final airItineraryJson = <String, dynamic>{
      'OriginDestinationOptions': json['OriginDestinationOptions'],
      'IsPassportMandatory': json['IsPassportMandatory'],
      'SequenceNumber': json['SequenceNumber'],
      'TicketType': json['TicketType'],
      'ValidatingAirlineCode': json['ValidatingAirlineCode'],
    };

    return FareItinerary(
      directionInd: _stringFromJson(json['DirectionInd']),
      airItineraryFareInfo: _airItineraryFareInfoFromJson(
        json['AirItineraryFareInfo'],
      ),
      airItinerary: AirItinerary.fromJson(airItineraryJson),
    );
  }

  Map<String, dynamic> toJson() => _$FareItineraryToJson(this);
}
