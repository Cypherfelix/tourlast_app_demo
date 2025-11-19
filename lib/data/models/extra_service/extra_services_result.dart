import 'package:json_annotation/json_annotation.dart';

import 'extra_services_data.dart';

part 'extra_services_result.g.dart';

@JsonSerializable()
class ExtraServicesResult {
  const ExtraServicesResult({
    required this.success,
    required this.extraServicesData,
  });

  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'ExtraServicesData')
  final ExtraServicesData extraServicesData;

  factory ExtraServicesResult.fromJson(Map<String, dynamic> json) =>
      _$ExtraServicesResultFromJson(json);
  Map<String, dynamic> toJson() => _$ExtraServicesResultToJson(this);
}
