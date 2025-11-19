// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tax.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tax _$TaxFromJson(Map<String, dynamic> json) => Tax(
      taxCode: json['TaxCode'] as String?,
      amount: json['Amount'] as String,
      currencyCode: json['CurrencyCode'] as String,
      decimalPlaces: json['DecimalPlaces'] as String,
    );

Map<String, dynamic> _$TaxToJson(Tax instance) => <String, dynamic>{
      'TaxCode': instance.taxCode,
      'Amount': instance.amount,
      'CurrencyCode': instance.currencyCode,
      'DecimalPlaces': instance.decimalPlaces,
    };
