import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../widgets/home/models/search_params.dart';
import '../../widgets/flights/flight_list/flight_list.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key, required this.searchParams});

  final SearchParams searchParams;

  String get _formattedDate =>
      DateFormat('EEE, d MMM yyyy').format(searchParams.departureDate);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${searchParams.origin} → ${searchParams.destination}',
              style: AppTypography.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              _formattedDate,
              style: AppTypography.textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: FlightList(
          onFlightTap: (fareItinerary) {
            // TODO: Navigate to flight details in Story 6.1
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Flight ${fareItinerary.airItinerary.originDestinationOptions.firstOrNull?.originDestinationOption.firstOrNull?.flightSegment.flightNumber ?? 'N/A'} selected',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
