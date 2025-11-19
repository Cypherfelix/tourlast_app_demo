import 'package:json_annotation/json_annotation.dart';

import '../common/money.dart';
import 'tax.dart';

part 'passenger_fare.g.dart';

@JsonSerializable()
class PassengerFare {
  const PassengerFare({
    required this.baseFare,
    required this.equivFare,
    required this.serviceTax,
    required this.surcharges,
    required this.taxes,
    required this.totalFare,
  });

  @JsonKey(name: 'BaseFare')
  final Money baseFare;

  @JsonKey(name: 'EquivFare')
  final Money equivFare;

  @JsonKey(name: 'ServiceTax')
  final Money serviceTax;

  @JsonKey(name: 'Surcharges')
  final Money surcharges;

  @JsonKey(name: 'Taxes')
  final List<Tax> taxes;

  @JsonKey(name: 'TotalFare')
  final Money totalFare;

  factory PassengerFare.fromJson(Map<String, dynamic> json) =>
      _$PassengerFareFromJson(json);
  Map<String, dynamic> toJson() => _$PassengerFareToJson(this);
}
