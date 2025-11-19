// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tax _$TaxFromJson(Map<String, dynamic> json) => Tax(
      taxCode: json['TaxCode'] as String?,
      amount: Tax._stringFromJson(json['Amount']),
      currencyCode: Tax._stringFromJson(json['CurrencyCode']),
      decimalPlaces: Tax._stringFromJsonNullable(json['DecimalPlaces']),
    );

Map<String, dynamic> _$TaxToJson(Tax instance) => <String, dynamic>{
      'TaxCode': instance.taxCode,
      'Amount': instance.amount,
      'CurrencyCode': instance.currencyCode,
      'DecimalPlaces': instance.decimalPlaces,
    };
