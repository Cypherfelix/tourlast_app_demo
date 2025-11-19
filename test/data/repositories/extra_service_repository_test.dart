import 'package:flutter_test/flutter_test.dart';
import 'package:tourlast_app/data/repositories/extra_service_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ExtraServiceRepository Tests', () {
    late ExtraServiceRepository repository;

    setUp(() {
      repository = ExtraServiceRepository.instance;
      repository.clearCache();
    });

    test('should load extra services from JSON file', () async {
      final services = await repository.getExtraServices();

      expect(services, isNotNull);
      expect(
        services.extraServicesResponse.extraServicesResult.success,
        isTrue,
      );
    });

    test('should cache extra services data', () async {
      final services1 = await repository.getExtraServices();
      final timestamp1 = DateTime.now();

      final services2 = await repository.getExtraServices();
      final timestamp2 = DateTime.now();

      expect(services1, equals(services2));
      expect(timestamp2.difference(timestamp1).inMilliseconds, lessThan(100));
    });

    test('should refresh when forceRefresh is true', () async {
      await repository.getExtraServices();
      final services = await repository.getExtraServices(forceRefresh: true);

      expect(services, isNotNull);
      expect(
        services.extraServicesResponse.extraServicesResult.success,
        isTrue,
      );
    });

    test('should handle services with baggage data', () async {
      final services = await repository.getExtraServices();

      final baggage = services
          .extraServicesResponse
          .extraServicesResult
          .extraServicesData
          .dynamicBaggage;

      // May or may not have baggage, but should not throw
      expect(baggage, isA<List>());
    });

    test('should clear cache', () {
      expect(() => repository.clearCache(), returnsNormally);
    });
  });
}
