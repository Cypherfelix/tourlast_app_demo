import 'package:json_annotation/json_annotation.dart';

import '../common/money.dart';

part 'itin_total_fares.g.dart';

@JsonSerializable()
class ItinTotalFares {
  const ItinTotalFares({
    required this.baseFare,
    required this.equivFare,
    required this.serviceTax,
    required this.totalTax,
    required this.totalFare,
  });

  @JsonKey(name: 'BaseFare')
  final Money baseFare;

  @JsonKey(name: 'EquivFare')
  final Money equivFare;

  @JsonKey(name: 'ServiceTax')
  final Money serviceTax;

  @JsonKey(name: 'TotalTax')
  final Money totalTax;

  @JsonKey(name: 'TotalFare')
  final Money totalFare;

  factory ItinTotalFares.fromJson(Map<String, dynamic> json) =>
      _$ItinTotalFaresFromJson(json);
  Map<String, dynamic> toJson() => _$ItinTotalFaresToJson(this);
}
