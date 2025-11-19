import 'package:json_annotation/json_annotation.dart';

import 'dynamic_baggage.dart';

part 'extra_services_data.g.dart';

@JsonSerializable()
class ExtraServicesData {
  const ExtraServicesData({
    required this.dynamicBaggage,
    required this.dynamicMeal,
    required this.dynamicSeat,
  });

  @JsonKey(name: 'DynamicBaggage')
  final List<DynamicBaggage> dynamicBaggage;

  @JsonKey(name: 'DynamicMeal')
  final List<dynamic> dynamicMeal;

  @JsonKey(name: 'DynamicSeat')
  final List<dynamic> dynamicSeat;

  factory ExtraServicesData.fromJson(Map<String, dynamic> json) =>
      _$ExtraServicesDataFromJson(json);
  Map<String, dynamic> toJson() => _$ExtraServicesDataToJson(this);
}
