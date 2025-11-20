/// Model for passenger information
class PassengerInfo {
  const PassengerInfo({
    required this.type,
    required this.firstName,
    required this.lastName,
    this.middleName,
    required this.dateOfBirth,
    this.gender,
    this.passportNumber,
    this.passportExpiryDate,
    this.nationality,
    this.email,
    this.phoneNumber,
  });

  final PassengerType type;
  final String firstName;
  final String lastName;
  final String? middleName;
  final DateTime dateOfBirth;
  final String? gender;
  final String? passportNumber;
  final DateTime? passportExpiryDate;
  final String? nationality;
  final String? email;
  final String? phoneNumber;

  PassengerInfo copyWith({
    PassengerType? type,
    String? firstName,
    String? lastName,
    String? middleName,
    DateTime? dateOfBirth,
    String? gender,
    String? passportNumber,
    DateTime? passportExpiryDate,
    String? nationality,
    String? email,
    String? phoneNumber,
  }) {
    return PassengerInfo(
      type: type ?? this.type,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      middleName: middleName ?? this.middleName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      passportNumber: passportNumber ?? this.passportNumber,
      passportExpiryDate: passportExpiryDate ?? this.passportExpiryDate,
      nationality: nationality ?? this.nationality,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  bool get isValid {
    return firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        dateOfBirth.isBefore(DateTime.now());
  }
}

enum PassengerType { adult, child, infant }

