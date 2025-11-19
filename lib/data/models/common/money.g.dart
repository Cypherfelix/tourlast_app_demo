// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Money _$MoneyFromJson(Map<String, dynamic> json) => Money(
      amount: Money._stringFromJson(json['Amount']),
      currencyCode: Money._stringFromJson(json['CurrencyCode']),
      decimalPlaces: Money._stringFromJsonNullable(json['DecimalPlaces']),
    );

Map<String, dynamic> _$MoneyToJson(Money instance) => <String, dynamic>{
      'Amount': instance.amount,
      'CurrencyCode': instance.currencyCode,
      'DecimalPlaces': instance.decimalPlaces,
    };
