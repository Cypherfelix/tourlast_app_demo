import 'package:flutter_test/flutter_test.dart';
import 'package:tourlast_app/data/models/flight/tax.dart';
import 'package:tourlast_app/data/models/flight/passenger_fare.dart';
import 'package:tourlast_app/data/models/flight/fare_breakdown.dart';
import 'package:tourlast_app/data/models/flight/passenger_type_quantity.dart';
import 'package:tourlast_app/data/models/flight/penalty_details.dart';

void main() {
  group('Flight Models Edge Cases', () {
    test('Tax should handle null TaxCode', () {
      final json = {
        'TaxCode': null,
        'Amount': '10.00',
        'CurrencyCode': 'USD',
        'DecimalPlaces': '2',
      };

      expect(() => Tax.fromJson(json), returnsNormally);
      final tax = Tax.fromJson(json);
      expect(tax.taxCode, isNull);
      expect(tax.amount, '10.00');
    });

    test('Tax should handle empty TaxCode', () {
      final json = {
        'TaxCode': '',
        'Amount': '10.00',
        'CurrencyCode': 'USD',
        'DecimalPlaces': '2',
      };

      final tax = Tax.fromJson(json);
      expect(tax.taxCode, '');
    });

    test('PassengerTypeQuantity should handle various passenger types', () {
      final types = ['ADT', 'CHD', 'INF'];
      for (final type in types) {
        final json = {'Code': type, 'Quantity': 1};

        final ptq = PassengerTypeQuantity.fromJson(json);
        expect(ptq.code, type);
        expect(ptq.quantity, 1);
      }
    });

    test('PassengerTypeQuantity should handle zero quantity', () {
      final json = {'Code': 'ADT', 'Quantity': 0};

      final ptq = PassengerTypeQuantity.fromJson(json);
      expect(ptq.quantity, 0);
    });

    test('PassengerTypeQuantity should handle large quantities', () {
      final json = {'Code': 'ADT', 'Quantity': 99};

      final ptq = PassengerTypeQuantity.fromJson(json);
      expect(ptq.quantity, 99);
    });

    test('PenaltyDetails should handle all boolean combinations', () {
      final combinations = [
        {'refund': true, 'change': true},
        {'refund': true, 'change': false},
        {'refund': false, 'change': true},
        {'refund': false, 'change': false},
      ];

      for (final combo in combinations) {
        final json = {
          'Currency': 'USD',
          'RefundAllowed': combo['refund'],
          'RefundPenaltyAmount': '0.00',
          'ChangeAllowed': combo['change'],
          'ChangePenaltyAmount': '0.00',
        };

        final penalty = PenaltyDetails.fromJson(json);
        expect(penalty.refundAllowed, combo['refund']);
        expect(penalty.changeAllowed, combo['change']);
      }
    });

    test('PenaltyDetails should handle zero penalty amounts', () {
      final json = {
        'Currency': 'USD',
        'RefundAllowed': false,
        'RefundPenaltyAmount': '0.00',
        'ChangeAllowed': false,
        'ChangePenaltyAmount': '0.00',
      };

      final penalty = PenaltyDetails.fromJson(json);
      expect(penalty.refundPenaltyAmount, '0.00');
      expect(penalty.changePenaltyAmount, '0.00');
    });

    test('PenaltyDetails should handle large penalty amounts', () {
      final json = {
        'Currency': 'USD',
        'RefundAllowed': true,
        'RefundPenaltyAmount': '500.00',
        'ChangeAllowed': true,
        'ChangePenaltyAmount': '300.00',
      };

      final penalty = PenaltyDetails.fromJson(json);
      expect(penalty.refundPenaltyAmount, '500.00');
      expect(penalty.changePenaltyAmount, '300.00');
    });

    test('FareBreakdown should handle empty baggage arrays', () {
      final json = {
        'FareBasisCode': '',
        'Baggage': [],
        'CabinBaggage': [],
        'PassengerFare': {
          'BaseFare': {'Amount': '100.00', 'CurrencyCode': 'USD'},
          'EquivFare': {'Amount': '100.00', 'CurrencyCode': 'USD'},
          'ServiceTax': {'Amount': '0.00', 'CurrencyCode': 'USD'},
          'Surcharges': {'Amount': '0.00', 'CurrencyCode': 'USD'},
          'Taxes': [],
          'TotalFare': {'Amount': '100.00', 'CurrencyCode': 'USD'},
        },
        'PassengerTypeQuantity': {'Code': 'ADT', 'Quantity': 1},
        'PenaltyDetails': {
          'Currency': 'USD',
          'RefundAllowed': false,
          'RefundPenaltyAmount': '0.00',
          'ChangeAllowed': false,
          'ChangePenaltyAmount': '0.00',
        },
      };

      expect(() => FareBreakdown.fromJson(json), returnsNormally);
      final breakdown = FareBreakdown.fromJson(json);
      expect(breakdown.baggage, isEmpty);
      expect(breakdown.cabinBaggage, isEmpty);
    });

    test('FareBreakdown should handle null FareBasisCode', () {
      final json = {
        'FareBasisCode': null,
        'Baggage': ['SB'],
        'CabinBaggage': ['SB'],
        'PassengerFare': {
          'BaseFare': {'Amount': '100.00', 'CurrencyCode': 'USD'},
          'EquivFare': {'Amount': '100.00', 'CurrencyCode': 'USD'},
          'ServiceTax': {'Amount': '0.00', 'CurrencyCode': 'USD'},
          'Surcharges': {'Amount': '0.00', 'CurrencyCode': 'USD'},
          'Taxes': [],
          'TotalFare': {'Amount': '100.00', 'CurrencyCode': 'USD'},
        },
        'PassengerTypeQuantity': {'Code': 'ADT', 'Quantity': 1},
        'PenaltyDetails': {
          'Currency': 'USD',
          'RefundAllowed': false,
          'RefundPenaltyAmount': '0.00',
          'ChangeAllowed': false,
          'ChangePenaltyAmount': '0.00',
        },
      };

      expect(() => FareBreakdown.fromJson(json), returnsNormally);
      final breakdown = FareBreakdown.fromJson(json);
      expect(breakdown.fareBasisCode, isNull);
    });

    test('PassengerFare should handle empty taxes array', () {
      final json = {
        'BaseFare': {'Amount': '100.00', 'CurrencyCode': 'USD'},
        'EquivFare': {'Amount': '100.00', 'CurrencyCode': 'USD'},
        'ServiceTax': {'Amount': '0.00', 'CurrencyCode': 'USD'},
        'Surcharges': {'Amount': '0.00', 'CurrencyCode': 'USD'},
        'Taxes': [],
        'TotalFare': {'Amount': '100.00', 'CurrencyCode': 'USD'},
      };

      expect(() => PassengerFare.fromJson(json), returnsNormally);
      final fare = PassengerFare.fromJson(json);
      expect(fare.taxes, isEmpty);
    });

    test('PassengerFare should handle multiple taxes', () {
      final json = {
        'BaseFare': {'Amount': '100.00', 'CurrencyCode': 'USD'},
        'EquivFare': {'Amount': '100.00', 'CurrencyCode': 'USD'},
        'ServiceTax': {'Amount': '0.00', 'CurrencyCode': 'USD'},
        'Surcharges': {'Amount': '0.00', 'CurrencyCode': 'USD'},
        'Taxes': [
          {
            'TaxCode': 'TAX',
            'Amount': '10.00',
            'CurrencyCode': 'USD',
            'DecimalPlaces': '2',
          },
          {
            'TaxCode': 'Tax2',
            'Amount': '5.00',
            'CurrencyCode': 'USD',
            'DecimalPlaces': '2',
          },
        ],
        'TotalFare': {'Amount': '115.00', 'CurrencyCode': 'USD'},
      };

      final fare = PassengerFare.fromJson(json);
      expect(fare.taxes.length, 2);
    });

    test('Tax should handle null DecimalPlaces', () {
      final json = {
        'TaxCode': 'TAX',
        'Amount': '10.00',
        'CurrencyCode': 'USD',
        'DecimalPlaces': null,
      };

      expect(() => Tax.fromJson(json), returnsNormally);
      final tax = Tax.fromJson(json);
      expect(tax.decimalPlaces, isNull);
    });
  });
}
