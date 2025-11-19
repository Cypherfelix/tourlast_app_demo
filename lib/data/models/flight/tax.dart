import 'package:json_annotation/json_annotation.dart';

part 'tax.g.dart';

@JsonSerializable()
class Tax {
  const Tax({
    this.taxCode,
    required this.amount,
    required this.currencyCode,
    required this.decimalPlaces,
  });

  @JsonKey(name: 'TaxCode')
  final String? taxCode;

  @JsonKey(name: 'Amount')
  final String amount;

  @JsonKey(name: 'CurrencyCode')
  final String currencyCode;

  @JsonKey(name: 'DecimalPlaces')
  final String decimalPlaces;

  factory Tax.fromJson(Map<String, dynamic> json) => _$TaxFromJson(json);
  Map<String, dynamic> toJson() => _$TaxToJson(this);

  double get amountValue => double.tryParse(amount) ?? 0.0;
}
