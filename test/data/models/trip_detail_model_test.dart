import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tourlast_app/data/models/trip_detail/trip_details_response.dart';
import 'package:tourlast_app/data/models/trip_detail/customer_info.dart';
import 'package:tourlast_app/data/models/trip_detail/reservation_item.dart';

void main() {
  group('TripDetail Model Tests', () {
    test('should parse valid customer info JSON', () {
      final json = {
        'PassengerType': 'ADT',
        'PassengerFirstName': 'John',
        'PassengerLastName': 'Doe',
        'PassengerTitle': 'Mr',
        'ItemRPH': 1,
        'eTicketNumber': 'AHFYWJ',
        'DateOfBirth': '2004-10-30T00:00:00',
        'EmailAddress': 'john.doe@gmail.com',
        'Gender': null,
        'PassengerNationality': 'IN',
        'PassportNumber': '5467455',
        'PhoneNumber': '9847012345',
        'PostCode': '',
      };

      final customerInfo = CustomerInfo.fromJson(json);

      expect(customerInfo.passengerType, 'ADT');
      expect(customerInfo.passengerFirstName, 'John');
      expect(customerInfo.passengerLastName, 'Doe');
      expect(customerInfo.gender, isNull);
      expect(customerInfo.postCode, '');
    });

    test('should handle null gender in customer info', () {
      final json = {
        'PassengerType': 'ADT',
        'PassengerFirstName': 'John',
        'PassengerLastName': 'Doe',
        'PassengerTitle': 'Mr',
        'ItemRPH': 1,
        'eTicketNumber': 'AHFYWJ',
        'DateOfBirth': '2004-10-30T00:00:00',
        'EmailAddress': 'john.doe@gmail.com',
        'Gender': null,
        'PassengerNationality': 'IN',
        'PassportNumber': '5467455',
        'PhoneNumber': '9847012345',
        'PostCode': '',
      };

      expect(() => CustomerInfo.fromJson(json), returnsNormally);
      final customerInfo = CustomerInfo.fromJson(json);
      expect(customerInfo.gender, isNull);
    });

    test('should parse valid reservation item JSON', () {
      final json = {
        'AirEquipmentType': null,
        'AirlinePNR': 'AHFYWJ',
        'ArrivalAirportLocationCode': 'STN',
        'ArrivalDateTime': '2025-12-14T12:50:00',
        'ArrivalTerminal': null,
        'Baggage': '10 KG',
        'CabinClassText': 'BASIC',
        'DepartureAirportLocationCode': 'RTM',
        'DepartureDateTime': '2025-12-14T12:55:00',
        'DepartureTerminal': null,
        'FlightNumber': '6993',
        'ItemRPH': 1,
        'JourneyDuration': '55',
        'MarketingAirlineCode': 'HV',
        'NumberInParty': 1,
        'OperatingAirlineCode': 'HV',
        'ResBookDesigCode': 'S',
        'StopQuantity': 0,
      };

      final reservation = ReservationItem.fromJson(json);

      expect(reservation.airlinePNR, 'AHFYWJ');
      expect(reservation.flightNumber, '6993');
      expect(reservation.stopQuantity, 0);
      expect(reservation.airEquipmentType, isNull);
      expect(reservation.arrivalTerminal, isNull);
    });

    test('should handle null optional fields in reservation item', () {
      final json = {
        'AirEquipmentType': null,
        'AirlinePNR': 'AHFYWJ',
        'ArrivalAirportLocationCode': 'STN',
        'ArrivalDateTime': '2025-12-14T12:50:00',
        'ArrivalTerminal': null,
        'Baggage': '10 KG',
        'CabinClassText': 'BASIC',
        'DepartureAirportLocationCode': 'RTM',
        'DepartureDateTime': '2025-12-14T12:55:00',
        'DepartureTerminal': null,
        'FlightNumber': '6993',
        'ItemRPH': 1,
        'JourneyDuration': '55',
        'MarketingAirlineCode': 'HV',
        'NumberInParty': 1,
        'OperatingAirlineCode': 'HV',
        'ResBookDesigCode': 'S',
        'StopQuantity': 0,
      };

      expect(() => ReservationItem.fromJson(json), returnsNormally);
      final reservation = ReservationItem.fromJson(json);
      expect(reservation.airEquipmentType, isNull);
      expect(reservation.arrivalTerminal, isNull);
      expect(reservation.departureTerminal, isNull);
    });

    test('should parse trip-details.json successfully', () {
      final file = File('lib/data/json-files/trip-details.json');
      final jsonString = file.readAsStringSync();
      final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;

      expect(
        () => TripDetailsResponse.fromJson(jsonData),
        returnsNormally,
        reason: 'Should parse TripDetailsResponse without errors',
      );

      final response = TripDetailsResponse.fromJson(jsonData);

      expect(response.tripDetailsResponse.tripDetailsResult.success, 'true');

      final itinerary =
          response.tripDetailsResponse.tripDetailsResult.travelItinerary;

      expect(itinerary.bookingStatus, isNotEmpty);
      expect(itinerary.origin, isNotEmpty);
      expect(itinerary.destination, isNotEmpty);
      expect(itinerary.itineraryInfo.customerInfos, isNotEmpty);
      expect(itinerary.itineraryInfo.reservationItems, isNotEmpty);
    });

    test('should handle empty customer infos', () {
      final json = {
        'TripDetailsResponse': {
          'TripDetailsResult': {
            'Success': 'true',
            'Target': 'Test',
            'TravelItinerary': {
              'BookingStatus': 'Booked',
              'CrossBorderIndicator': false,
              'Destination': 'STN',
              'FareType': 'WebFare',
              'IsCommissionable': false,
              'IsMOFare': false,
              'ItineraryInfo': {
                'CustomerInfos': [],
                'ItineraryPricing': {
                  'EquiFare': {'Amount': '0.00', 'CurrencyCode': 'USD'},
                  'ServiceTax': {'Amount': '0.00', 'CurrencyCode': 'USD'},
                  'Tax': {'Amount': '0.00', 'CurrencyCode': 'USD'},
                  'TotalFare': {'Amount': '0.00', 'CurrencyCode': 'USD'},
                },
                'ReservationItems': [],
                'TripDetailsPTC_FareBreakdowns': [],
                'ExtraServices': {'Services': []},
                'BookingNotes': [],
              },
              'UniqueID': 'TR81142025',
              'Origin': 'RTM',
              'TicketStatus': 'Ticketed',
            },
          },
        },
      };

      expect(() => TripDetailsResponse.fromJson(json), returnsNormally);
      final response = TripDetailsResponse.fromJson(json);
      expect(
        response
            .tripDetailsResponse
            .tripDetailsResult
            .travelItinerary
            .itineraryInfo
            .customerInfos,
        isEmpty,
      );
    });

    test('should handle various passenger types', () {
      final passengerTypes = ['ADT', 'CHD', 'INF'];
      for (final type in passengerTypes) {
        final json = {
          'PassengerType': type,
          'PassengerFirstName': 'Test',
          'PassengerLastName': 'User',
          'PassengerTitle': 'Mr',
          'ItemRPH': 1,
          'eTicketNumber': 'TEST123',
          'DateOfBirth': '2000-01-01T00:00:00',
          'EmailAddress': 'test@example.com',
          'Gender': null,
          'PassengerNationality': 'US',
          'PassportNumber': '123456',
          'PhoneNumber': '1234567890',
          'PostCode': '12345',
        };

        expect(() => CustomerInfo.fromJson(json), returnsNormally);
        final customer = CustomerInfo.fromJson(json);
        expect(customer.passengerType, type);
      }
    });
  });
}
