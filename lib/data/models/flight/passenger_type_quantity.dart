import 'package:json_annotation/json_annotation.dart';

part 'passenger_type_quantity.g.dart';

@JsonSerializable()
class PassengerTypeQuantity {
  const PassengerTypeQuantity({required this.code, required this.quantity});

  @JsonKey(name: 'Code')
  final String code;

  @JsonKey(name: 'Quantity')
  final int quantity;

  factory PassengerTypeQuantity.fromJson(Map<String, dynamic> json) =>
      _$PassengerTypeQuantityFromJson(json);
  Map<String, dynamic> toJson() => _$PassengerTypeQuantityToJson(this);
}
