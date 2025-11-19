import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../widgets/home/models/search_params.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key, required this.searchParams});

  final SearchParams searchParams;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Flight Results',
          style: AppTypography.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.flight_takeoff_rounded,
                size: 64,
                color: AppColors.primaryBlue.withOpacity(0.5),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                'Results Screen',
                style: AppTypography.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Search Parameters:',
                style: AppTypography.textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${searchParams.origin} → ${searchParams.destination}',
                style: AppTypography.textTheme.bodyLarge?.copyWith(
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Date: ${searchParams.departureDate.toString().split(' ')[0]}',
                style: AppTypography.textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Travelers: ${searchParams.adults}A ${searchParams.children}C ${searchParams.infants}I',
                style: AppTypography.textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Flight list will be implemented in Story 5.1',
                style: AppTypography.textTheme.bodySmall?.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
