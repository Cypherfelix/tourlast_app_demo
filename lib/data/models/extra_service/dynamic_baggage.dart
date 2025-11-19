import 'package:json_annotation/json_annotation.dart';

import 'extra_service.dart';

part 'dynamic_baggage.g.dart';

@JsonSerializable()
class DynamicBaggage {
  const DynamicBaggage({
    required this.behavior,
    required this.isMultiSelect,
    required this.services,
  });

  @JsonKey(name: 'Behavior')
  final String behavior;

  @JsonKey(name: 'IsMultiSelect')
  final bool isMultiSelect;

  @JsonKey(name: 'Services')
  final List<List<ExtraService>> services;

  factory DynamicBaggage.fromJson(Map<String, dynamic> json) =>
      _$DynamicBaggageFromJson(json);
  Map<String, dynamic> toJson() => _$DynamicBaggageToJson(this);
}
