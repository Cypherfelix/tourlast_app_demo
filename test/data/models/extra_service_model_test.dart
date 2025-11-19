import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tourlast_app/data/models/extra_service/extra_services_response.dart';
import 'package:tourlast_app/data/models/extra_service/extra_service.dart';
import 'package:tourlast_app/data/models/common/money.dart';

void main() {
  group('ExtraService Model Tests', () {
    test('should parse valid extra service JSON', () {
      final json = {
        'ServiceId': '1',
        'CheckInType': 'AIRPORT',
        'Description': '1 bags - 15Kg',
        'FareDescription': 'The charges are added while making the ticket',
        'IsMandatory': false,
        'MinimumQuantity': 0,
        'MaximumQuantity': 3,
        'ServiceCost': {
          'CurrencyCode': 'USD',
          'Amount': '51.92',
          'DecimalPlaces': '2',
        },
      };

      final service = ExtraService.fromJson(json);

      expect(service.serviceId, '1');
      expect(service.checkInType, 'AIRPORT');
      expect(service.description, '1 bags - 15Kg');
      expect(service.isMandatory, false);
      expect(service.minimumQuantity, 0);
      expect(service.maximumQuantity, 3);
      expect(service.serviceCost.amount, '51.92');
    });

    test('should handle null DecimalPlaces in ServiceCost', () {
      final json = {
        'ServiceId': '1',
        'CheckInType': 'AIRPORT',
        'Description': '1 bags - 15Kg',
        'FareDescription': 'Description',
        'IsMandatory': false,
        'MinimumQuantity': 0,
        'MaximumQuantity': 3,
        'ServiceCost': {
          'CurrencyCode': 'USD',
          'Amount': '51.92',
          'DecimalPlaces': null,
        },
      };

      expect(() => ExtraService.fromJson(json), returnsNormally);
      final service = ExtraService.fromJson(json);
      expect(service.serviceCost.decimalPlaces, isNull);
    });

    test('should handle missing DecimalPlaces in ServiceCost', () {
      final json = {
        'ServiceId': '1',
        'CheckInType': 'AIRPORT',
        'Description': '1 bags - 15Kg',
        'FareDescription': 'Description',
        'IsMandatory': false,
        'MinimumQuantity': 0,
        'MaximumQuantity': 3,
        'ServiceCost': {'CurrencyCode': 'USD', 'Amount': '51.92'},
      };

      expect(() => ExtraService.fromJson(json), returnsNormally);
    });

    test('should handle zero quantities', () {
      final json = {
        'ServiceId': '1',
        'CheckInType': 'AIRPORT',
        'Description': '1 bags - 15Kg',
        'FareDescription': 'Description',
        'IsMandatory': false,
        'MinimumQuantity': 0,
        'MaximumQuantity': 0,
        'ServiceCost': {'CurrencyCode': 'USD', 'Amount': '0.00'},
      };

      final service = ExtraService.fromJson(json);
      expect(service.minimumQuantity, 0);
      expect(service.maximumQuantity, 0);
    });

    test('should handle large quantities', () {
      final json = {
        'ServiceId': '1',
        'CheckInType': 'AIRPORT',
        'Description': '1 bags - 15Kg',
        'FareDescription': 'Description',
        'IsMandatory': false,
        'MinimumQuantity': 0,
        'MaximumQuantity': 999,
        'ServiceCost': {'CurrencyCode': 'USD', 'Amount': '51.92'},
      };

      final service = ExtraService.fromJson(json);
      expect(service.maximumQuantity, 999);
    });

    test('should parse extra-services.json successfully', () {
      final file = File('lib/data/json-files/extra-services.json');
      final jsonString = file.readAsStringSync();
      final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;

      expect(
        () => ExtraServicesResponse.fromJson(jsonData),
        returnsNormally,
        reason: 'Should parse ExtraServicesResponse without errors',
      );

      final response = ExtraServicesResponse.fromJson(jsonData);

      expect(
        response.extraServicesResponse.extraServicesResult.success,
        isTrue,
      );

      final data =
          response.extraServicesResponse.extraServicesResult.extraServicesData;

      // Check baggage services
      if (data.dynamicBaggage.isNotEmpty) {
        for (final baggage in data.dynamicBaggage) {
          expect(baggage.behavior, isNotEmpty);
          expect(baggage.services, isNotEmpty);

          for (final serviceGroup in baggage.services) {
            for (final service in serviceGroup) {
              expect(service.serviceId, isNotEmpty);
              expect(service.description, isNotEmpty);
              expect(service.serviceCost.amount, isNotEmpty);
            }
          }
        }
      }
    });

    test('should handle empty service lists', () {
      final json = {
        'ExtraServicesResponse': {
          'ExtraServicesResult': {
            'success': true,
            'ExtraServicesData': {
              'DynamicBaggage': [],
              'DynamicMeal': [],
              'DynamicSeat': [],
            },
          },
        },
      };

      expect(() => ExtraServicesResponse.fromJson(json), returnsNormally);

      final response = ExtraServicesResponse.fromJson(json);
      expect(
        response
            .extraServicesResponse
            .extraServicesResult
            .extraServicesData
            .dynamicBaggage,
        isEmpty,
      );
    });
  });
}
