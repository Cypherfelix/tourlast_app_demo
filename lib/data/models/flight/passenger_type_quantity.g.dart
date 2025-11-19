// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passenger_type_quantity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PassengerTypeQuantity _$PassengerTypeQuantityFromJson(
  Map<String, dynamic> json,
) => PassengerTypeQuantity(
  code: json['Code'] as String,
  quantity: (json['Quantity'] as num).toInt(),
);

Map<String, dynamic> _$PassengerTypeQuantityToJson(
  PassengerTypeQuantity instance,
) => <String, dynamic>{'Code': instance.code, 'Quantity': instance.quantity};
