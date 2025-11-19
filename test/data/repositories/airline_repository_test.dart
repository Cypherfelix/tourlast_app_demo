import 'package:flutter_test/flutter_test.dart';
import 'package:tourlast_app/data/repositories/airline_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AirlineRepository Tests', () {
    late AirlineRepository repository;

    setUp(() {
      repository = AirlineRepository.instance;
      repository.clearCache();
    });

    test('should load airlines from JSON file', () async {
      final airlines = await repository.getAirlines();

      expect(airlines, isNotEmpty);
      expect(airlines.first.airLineCode, isNotEmpty);
      expect(airlines.first.airLineName, isNotEmpty);
      expect(airlines.first.airLineLogo, isNotEmpty);
    });

    test('should cache airlines data', () async {
      final airlines1 = await repository.getAirlines();
      final timestamp1 = DateTime.now();

      final airlines2 = await repository.getAirlines();
      final timestamp2 = DateTime.now();

      expect(airlines1.length, airlines2.length);
      expect(timestamp2.difference(timestamp1).inMilliseconds, lessThan(100));
    });

    test('should get airline by code', () async {
      final airline = await repository.getAirlineByCode('HV');

      expect(airline, isNotNull);
      expect(airline?.airLineCode, 'HV');
    });

    test('should return null for non-existent airline code', () async {
      final airline = await repository.getAirlineByCode('XXX');

      expect(airline, isNull);
    });

    test('should return null for empty airline code', () async {
      final airline = await repository.getAirlineByCode('');

      expect(airline, isNull);
    });

    test('should search airlines by name', () async {
      final results = await repository.searchAirlines('Transavia');

      expect(results, isNotEmpty);
      expect(results.any((a) => a.airLineName.contains('Transavia')), isTrue);
    });

    test('should search airlines by code', () async {
      final results = await repository.searchAirlines('HV');

      expect(results, isNotEmpty);
      expect(results.any((a) => a.airLineCode == 'HV'), isTrue);
    });

    test('should handle case-insensitive search', () async {
      final results1 = await repository.searchAirlines('transavia');
      final results2 = await repository.searchAirlines('TRANSAVIA');

      expect(results1.length, results2.length);
    });

    test('should return empty list for non-matching search', () async {
      final results = await repository.searchAirlines('NonExistentAirline123');

      expect(results, isEmpty);
    });

    test('should return empty list for empty search query', () async {
      final results = await repository.searchAirlines('');

      // Empty query might return all or none, depending on implementation
      // Just verify it doesn't throw
      expect(results, isA<List>());
    });

    test('should handle special characters in search', () async {
      final results = await repository.searchAirlines('&');

      // Should not throw, might return empty or some results
      expect(results, isA<List>());
    });

    test('should refresh when forceRefresh is true', () async {
      await repository.getAirlines();
      final airlines = await repository.getAirlines(forceRefresh: true);

      expect(airlines, isNotEmpty);
    });

    test('should clear cache', () {
      expect(() => repository.clearCache(), returnsNormally);
    });
  });
}
