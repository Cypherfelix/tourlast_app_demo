import 'package:json_annotation/json_annotation.dart';

import 'extra_services_result.dart';

part 'extra_services_response.g.dart';

@JsonSerializable()
class ExtraServicesResponse {
  const ExtraServicesResponse({required this.extraServicesResponse});

  @JsonKey(name: 'ExtraServicesResponse')
  final ExtraServicesResponseData extraServicesResponse;

  factory ExtraServicesResponse.fromJson(Map<String, dynamic> json) =>
      _$ExtraServicesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ExtraServicesResponseToJson(this);
}

@JsonSerializable()
class ExtraServicesResponseData {
  const ExtraServicesResponseData({required this.extraServicesResult});

  @JsonKey(name: 'ExtraServicesResult')
  final ExtraServicesResult extraServicesResult;

  factory ExtraServicesResponseData.fromJson(Map<String, dynamic> json) =>
      _$ExtraServicesResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$ExtraServicesResponseDataToJson(this);
}
