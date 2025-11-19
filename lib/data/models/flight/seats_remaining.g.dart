// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seats_remaining.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatsRemaining _$SeatsRemainingFromJson(Map<String, dynamic> json) =>
    SeatsRemaining(
      belowMinimum: json['BelowMinimum'] as bool,
      number: (json['Number'] as num).toInt(),
    );

Map<String, dynamic> _$SeatsRemainingToJson(SeatsRemaining instance) =>
    <String, dynamic>{
      'BelowMinimum': instance.belowMinimum,
      'Number': instance.number,
    };
