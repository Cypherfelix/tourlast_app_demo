import 'package:json_annotation/json_annotation.dart';

part 'penalty_details.g.dart';

@JsonSerializable()
class PenaltyDetails {
  const PenaltyDetails({
    required this.currency,
    required this.refundAllowed,
    required this.refundPenaltyAmount,
    required this.changeAllowed,
    required this.changePenaltyAmount,
  });

  @JsonKey(name: 'Currency')
  final String currency;

  @JsonKey(name: 'RefundAllowed')
  final bool refundAllowed;

  @JsonKey(name: 'RefundPenaltyAmount')
  final String refundPenaltyAmount;

  @JsonKey(name: 'ChangeAllowed')
  final bool changeAllowed;

  @JsonKey(name: 'ChangePenaltyAmount')
  final String changePenaltyAmount;

  factory PenaltyDetails.fromJson(Map<String, dynamic> json) =>
      _$PenaltyDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$PenaltyDetailsToJson(this);
}
