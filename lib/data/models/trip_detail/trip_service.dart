import 'package:json_annotation/json_annotation.dart';

import '../common/money.dart';

part 'trip_service.g.dart';

@JsonSerializable()
class TripService {
  const TripService({
    required this.behavior,
    required this.checkInType,
    required this.description,
    this.flightDesignator,
    required this.isMandatory,
    this.relation,
    required this.serviceCost,
    required this.serviceId,
    required this.type,
  });

  @JsonKey(name: 'Behavior')
  final String behavior;

  @JsonKey(name: 'CheckInType')
  final String checkInType;

  @JsonKey(name: 'Description')
  final String description;

  @JsonKey(name: 'FlightDesignator')
  final String? flightDesignator;

  @JsonKey(name: 'IsMandatory')
  final bool isMandatory;

  @JsonKey(name: 'Relation')
  final String? relation;

  @JsonKey(name: 'ServiceCost')
  final Money serviceCost;

  @JsonKey(name: 'ServiceId')
  final String serviceId;

  @JsonKey(name: 'Type')
  final String type;

  factory TripService.fromJson(Map<String, dynamic> json) =>
      _$TripServiceFromJson(json);
  Map<String, dynamic> toJson() => _$TripServiceToJson(this);
}
