import 'package:json_annotation/json_annotation.dart';

import '../common/money.dart';

part 'extra_service.g.dart';

@JsonSerializable()
class ExtraService {
  const ExtraService({
    required this.serviceId,
    required this.checkInType,
    required this.description,
    required this.fareDescription,
    required this.isMandatory,
    required this.minimumQuantity,
    required this.maximumQuantity,
    required this.serviceCost,
  });

  @JsonKey(name: 'ServiceId')
  final String serviceId;

  @JsonKey(name: 'CheckInType')
  final String checkInType;

  @JsonKey(name: 'Description')
  final String description;

  @JsonKey(name: 'FareDescription')
  final String fareDescription;

  @JsonKey(name: 'IsMandatory')
  final bool isMandatory;

  @JsonKey(name: 'MinimumQuantity')
  final int minimumQuantity;

  @JsonKey(name: 'MaximumQuantity')
  final int maximumQuantity;

  @JsonKey(name: 'ServiceCost')
  final Money serviceCost;

  factory ExtraService.fromJson(Map<String, dynamic> json) =>
      _$ExtraServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ExtraServiceToJson(this);
}
