import 'package:json_annotation/json_annotation.dart';

part 'customer_info.g.dart';

@JsonSerializable()
class CustomerInfo {
  const CustomerInfo({
    required this.passengerType,
    required this.passengerFirstName,
    required this.passengerLastName,
    required this.passengerTitle,
    required this.itemRPH,
    required this.eTicketNumber,
    required this.dateOfBirth,
    required this.emailAddress,
    this.gender,
    required this.passengerNationality,
    required this.passportNumber,
    required this.phoneNumber,
    required this.postCode,
  });

  @JsonKey(name: 'PassengerType')
  final String passengerType;

  @JsonKey(name: 'PassengerFirstName')
  final String passengerFirstName;

  @JsonKey(name: 'PassengerLastName')
  final String passengerLastName;

  @JsonKey(name: 'PassengerTitle')
  final String passengerTitle;

  @JsonKey(name: 'ItemRPH')
  final int itemRPH;

  @JsonKey(name: 'eTicketNumber')
  final String eTicketNumber;

  @JsonKey(name: 'DateOfBirth')
  final String dateOfBirth;

  @JsonKey(name: 'EmailAddress')
  final String emailAddress;

  @JsonKey(name: 'Gender')
  final String? gender;

  @JsonKey(name: 'PassengerNationality')
  final String passengerNationality;

  @JsonKey(name: 'PassportNumber')
  final String passportNumber;

  @JsonKey(name: 'PhoneNumber')
  final String phoneNumber;

  @JsonKey(name: 'PostCode')
  final String postCode;

  factory CustomerInfo.fromJson(Map<String, dynamic> json) =>
      _$CustomerInfoFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerInfoToJson(this);
}
