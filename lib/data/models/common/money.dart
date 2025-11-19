import 'package:json_annotation/json_annotation.dart';

part 'money.g.dart';

@JsonSerializable()
class Money {
  const Money({
    required this.amount,
    required this.currencyCode,
    this.decimalPlaces,
  });

  @JsonKey(name: 'Amount', fromJson: _stringFromJson)
  final String amount;

  @JsonKey(name: 'CurrencyCode', fromJson: _stringFromJson)
  final String currencyCode;

  @JsonKey(name: 'DecimalPlaces', fromJson: _stringFromJsonNullable)
  final String? decimalPlaces;

  static String _stringFromJson(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }

  static String? _stringFromJsonNullable(dynamic value) {
    if (value == null) return null;
    return value.toString();
  }

  factory Money.fromJson(Map<String, dynamic> json) => _$MoneyFromJson(json);
  Map<String, dynamic> toJson() => _$MoneyToJson(this);

  double get amountValue => double.tryParse(amount) ?? 0.0;
}
