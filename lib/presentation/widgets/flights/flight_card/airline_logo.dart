import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../data/models/airline/airline.dart';
import '../../../../data/providers/repository_providers.dart';
import 'airline_logo_placeholder.dart';

/// Widget that displays airline logo from URL with caching and fallback.
class AirlineLogo extends ConsumerWidget {
  const AirlineLogo({
    super.key,
    required this.airlineCode,
    this.width = 52,
    this.height = 52,
  });

  final String airlineCode;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final airlineAsync = ref.watch(airlineByCodeProvider(airlineCode));

    return airlineAsync.when(
      data: (airline) {
        if (airline == null || airline.airLineLogo.isEmpty) {
          return AirlineLogoPlaceholder(width: width, height: height);
        }

        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: CachedNetworkImage(
              imageUrl: airline.airLineLogo,
              width: width,
              height: height,
              fit: BoxFit.contain,
              placeholder: (context, url) => Container(
                color: AppColors.surfaceMuted,
                child: Center(
                  child: SizedBox(
                    width: width * 0.4,
                    height: height * 0.4,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ),
              ),
              errorWidget: (context, url, error) =>
                  AirlineLogoPlaceholder(width: width, height: height),
              fadeInDuration: const Duration(milliseconds: 200),
              fadeOutDuration: const Duration(milliseconds: 100),
            ),
          ),
        );
      },
      loading: () => AirlineLogoPlaceholder(width: width, height: height),
      error: (_, __) => AirlineLogoPlaceholder(width: width, height: height),
    );
  }
}

/// Provider that fetches airline by code.
final airlineByCodeProvider = FutureProvider.family<Airline?, String>((
  ref,
  code,
) async {
  final repository = ref.watch(airlineRepositoryProvider);
  return repository.getAirlineByCode(code);
});
