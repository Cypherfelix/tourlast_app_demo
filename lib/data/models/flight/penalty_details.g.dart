// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'penalty_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PenaltyDetails _$PenaltyDetailsFromJson(Map<String, dynamic> json) =>
    PenaltyDetails(
      currency: json['Currency'] as String,
      refundAllowed: json['RefundAllowed'] as bool,
      refundPenaltyAmount: json['RefundPenaltyAmount'] as String,
      changeAllowed: json['ChangeAllowed'] as bool,
      changePenaltyAmount: json['ChangePenaltyAmount'] as String,
    );

Map<String, dynamic> _$PenaltyDetailsToJson(PenaltyDetails instance) =>
    <String, dynamic>{
      'Currency': instance.currency,
      'RefundAllowed': instance.refundAllowed,
      'RefundPenaltyAmount': instance.refundPenaltyAmount,
      'ChangeAllowed': instance.changeAllowed,
      'ChangePenaltyAmount': instance.changePenaltyAmount,
    };
