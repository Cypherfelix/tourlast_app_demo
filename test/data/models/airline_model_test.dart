import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tourlast_app/data/models/airline/airline.dart';

void main() {
  group('Airline Model Tests', () {
    test('should parse valid airline JSON', () {
      final json = {
        'AirLineCode': 'HV',
        'AirLineName': 'Transavia Airlines',
        'AirLineLogo': 'https://example.com/logo.gif',
      };

      final airline = Airline.fromJson(json);

      expect(airline.airLineCode, 'HV');
      expect(airline.airLineName, 'Transavia Airlines');
      expect(airline.airLineLogo, 'https://example.com/logo.gif');
    });

    test('should handle empty strings', () {
      final json = {'AirLineCode': '', 'AirLineName': '', 'AirLineLogo': ''};

      final airline = Airline.fromJson(json);

      expect(airline.airLineCode, '');
      expect(airline.airLineName, '');
      expect(airline.airLineLogo, '');
    });

    test('should handle long strings', () {
      final longString = 'A' * 1000;
      final json = {
        'AirLineCode': 'HV',
        'AirLineName': longString,
        'AirLineLogo': 'https://example.com/logo.gif',
      };

      final airline = Airline.fromJson(json);

      expect(airline.airLineName, longString);
    });

    test('should handle special characters in names', () {
      final json = {
        'AirLineCode': 'HV',
        'AirLineName': 'Airline & Co. (International)',
        'AirLineLogo': 'https://example.com/logo.gif',
      };

      final airline = Airline.fromJson(json);

      expect(airline.airLineName, 'Airline & Co. (International)');
    });

    test('should parse airline-list.json successfully', () {
      final file = File('lib/data/json-files/airline-list.json');
      final jsonString = file.readAsStringSync();
      final jsonList = jsonDecode(jsonString) as List<dynamic>;

      expect(jsonList, isNotEmpty);

      for (final json in jsonList.take(10)) {
        expect(
          () => Airline.fromJson(json as Map<String, dynamic>),
          returnsNormally,
          reason: 'Should parse airline without errors',
        );

        final airline = Airline.fromJson(json as Map<String, dynamic>);
        expect(airline.airLineCode, isNotEmpty);
        expect(airline.airLineName, isNotEmpty);
        // Logo might be empty in some cases
        expect(airline.airLineLogo, isA<String>());
      }
    });
  });
}
