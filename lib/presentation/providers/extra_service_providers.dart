import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/extra_service/extra_services_response.dart';
import '../../data/providers/repository_providers.dart';

/// Provider for extra services data.
final extraServicesProvider =
    FutureProvider<ExtraServicesResponse>((ref) async {
  final repository = ref.watch(extraServiceRepositoryProvider);
  return repository.getExtraServices();
});

