import 'package:json_annotation/json_annotation.dart';

part 'money.g.dart';

@JsonSerializable()
class Money {
  const Money({
    required this.amount,
    required this.currencyCode,
    required this.decimalPlaces,
  });

  final String amount;
  final String currencyCode;
  final String decimalPlaces;

  factory Money.fromJson(Map<String, dynamic> json) => _$MoneyFromJson(json);
  Map<String, dynamic> toJson() => _$MoneyToJson(this);

  double get amountValue => double.tryParse(amount) ?? 0.0;
}
