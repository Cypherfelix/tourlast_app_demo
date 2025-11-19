// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerInfo _$CustomerInfoFromJson(Map<String, dynamic> json) => CustomerInfo(
  passengerType: json['PassengerType'] as String,
  passengerFirstName: json['PassengerFirstName'] as String,
  passengerLastName: json['PassengerLastName'] as String,
  passengerTitle: json['PassengerTitle'] as String,
  itemRPH: (json['ItemRPH'] as num).toInt(),
  eTicketNumber: json['eTicketNumber'] as String,
  dateOfBirth: json['DateOfBirth'] as String,
  emailAddress: json['EmailAddress'] as String,
  gender: json['Gender'] as String?,
  passengerNationality: json['PassengerNationality'] as String,
  passportNumber: json['PassportNumber'] as String,
  phoneNumber: json['PhoneNumber'] as String,
  postCode: json['PostCode'] as String,
);

Map<String, dynamic> _$CustomerInfoToJson(CustomerInfo instance) =>
    <String, dynamic>{
      'PassengerType': instance.passengerType,
      'PassengerFirstName': instance.passengerFirstName,
      'PassengerLastName': instance.passengerLastName,
      'PassengerTitle': instance.passengerTitle,
      'ItemRPH': instance.itemRPH,
      'eTicketNumber': instance.eTicketNumber,
      'DateOfBirth': instance.dateOfBirth,
      'EmailAddress': instance.emailAddress,
      'Gender': instance.gender,
      'PassengerNationality': instance.passengerNationality,
      'PassportNumber': instance.passportNumber,
      'PhoneNumber': instance.phoneNumber,
      'PostCode': instance.postCode,
    };
