import 'package:flutter_test/flutter_test.dart';
import 'package:tourlast_app/data/models/common/money.dart';

void main() {
  group('Money Model Tests', () {
    test('should parse valid money JSON', () {
      final json = {
        'Amount': '100.50',
        'CurrencyCode': 'USD',
        'DecimalPlaces': '2',
      };

      final money = Money.fromJson(json);

      expect(money.amount, '100.50');
      expect(money.currencyCode, 'USD');
      expect(money.decimalPlaces, '2');
      expect(money.amountValue, 100.50);
    });

    test('should handle null DecimalPlaces', () {
      final json = {
        'Amount': '100.50',
        'CurrencyCode': 'USD',
        'DecimalPlaces': null,
      };

      expect(() => Money.fromJson(json), returnsNormally);
      final money = Money.fromJson(json);
      expect(money.decimalPlaces, isNull);
    });

    test('should handle missing DecimalPlaces', () {
      final json = {'Amount': '100.50', 'CurrencyCode': 'USD'};

      expect(() => Money.fromJson(json), returnsNormally);
      final money = Money.fromJson(json);
      expect(money.decimalPlaces, isNull);
    });

    test('should handle null Amount', () {
      final json = {'Amount': null, 'CurrencyCode': 'USD'};

      expect(() => Money.fromJson(json), returnsNormally);
      final money = Money.fromJson(json);
      expect(money.amount, '');
      expect(money.amountValue, 0.0);
    });

    test('should handle null CurrencyCode', () {
      final json = {'Amount': '100.50', 'CurrencyCode': null};

      expect(() => Money.fromJson(json), returnsNormally);
      final money = Money.fromJson(json);
      expect(money.currencyCode, '');
    });

    test('should handle empty strings', () {
      final json = {'Amount': '', 'CurrencyCode': '', 'DecimalPlaces': ''};

      expect(() => Money.fromJson(json), returnsNormally);
      final money = Money.fromJson(json);
      expect(money.amount, '');
      expect(money.currencyCode, '');
      expect(money.decimalPlaces, '');
      expect(money.amountValue, 0.0);
    });

    test('should handle large amounts', () {
      final json = {
        'Amount': '999999999.99',
        'CurrencyCode': 'USD',
        'DecimalPlaces': '2',
      };

      final money = Money.fromJson(json);
      expect(money.amountValue, 999999999.99);
    });

    test('should handle negative amounts', () {
      final json = {
        'Amount': '-100.50',
        'CurrencyCode': 'USD',
        'DecimalPlaces': '2',
      };

      final money = Money.fromJson(json);
      expect(money.amountValue, -100.50);
    });

    test('should handle invalid amount strings', () {
      final json = {
        'Amount': 'invalid',
        'CurrencyCode': 'USD',
        'DecimalPlaces': '2',
      };

      expect(() => Money.fromJson(json), returnsNormally);
      final money = Money.fromJson(json);
      expect(money.amountValue, 0.0);
    });

    test('should handle various currency codes', () {
      final currencies = ['USD', 'EUR', 'GBP', 'JPY', 'INR'];
      for (final currency in currencies) {
        final json = {
          'Amount': '100.00',
          'CurrencyCode': currency,
          'DecimalPlaces': '2',
        };

        final money = Money.fromJson(json);
        expect(money.currencyCode, currency);
      }
    });

    test('should handle zero amounts', () {
      final json = {
        'Amount': '0.00',
        'CurrencyCode': 'USD',
        'DecimalPlaces': '2',
      };

      final money = Money.fromJson(json);
      expect(money.amountValue, 0.0);
    });

    test('should handle DecimalPlaces as number', () {
      final json = {
        'Amount': '100.50',
        'CurrencyCode': 'USD',
        'DecimalPlaces': 2, // Sometimes JSON has numbers instead of strings
      };

      expect(() => Money.fromJson(json), returnsNormally);
      final money = Money.fromJson(json);
      expect(money.decimalPlaces, '2');
    });
  });
}
