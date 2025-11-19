import 'package:json_annotation/json_annotation.dart';

import '../common/money.dart';

part 'itinerary_pricing.g.dart';

@JsonSerializable()
class ItineraryPricing {
  const ItineraryPricing({
    required this.equiFare,
    required this.serviceTax,
    required this.tax,
    required this.totalFare,
  });

  @JsonKey(name: 'EquiFare')
  final Money equiFare;

  @JsonKey(name: 'ServiceTax')
  final Money serviceTax;

  @JsonKey(name: 'Tax')
  final Money tax;

  @JsonKey(name: 'TotalFare')
  final Money totalFare;

  factory ItineraryPricing.fromJson(Map<String, dynamic> json) =>
      _$ItineraryPricingFromJson(json);
  Map<String, dynamic> toJson() => _$ItineraryPricingToJson(this);
}
