import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../models/trip_type.dart';
import 'airport_pill.dart';
import 'info_row.dart';
import 'route_divider.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({
    super.key,
    required this.tripType,
    required this.origin,
    required this.destination,
    required this.selectedDate,
    this.returnDate,
    required this.adults,
    required this.children,
    required this.infants,
    required this.cabinClass,
    required this.currency,
    required this.onOriginTap,
    required this.onDestinationTap,
    required this.onDateTap,
    this.onReturnDateTap,
    required this.onTravelersTap,
    required this.onCabinTap,
    required this.onCurrencyTap,
  });

  final TripType tripType;
  final String origin;
  final String destination;
  final DateTime selectedDate;
  final DateTime? returnDate;
  final int adults;
  final int children;
  final int infants;
  final String cabinClass;
  final String currency;
  final VoidCallback onOriginTap;
  final VoidCallback onDestinationTap;
  final VoidCallback onDateTap;
  final VoidCallback? onReturnDateTap;
  final VoidCallback onTravelersTap;
  final VoidCallback onCabinTap;
  final VoidCallback onCurrencyTap;

  String get _formattedDate =>
      DateFormat('EEE, d MMM yyyy').format(selectedDate);

  String get _travelersText {
    final parts = <String>[];
    if (adults > 0) parts.add('$adults Adult${adults > 1 ? 's' : ''}');
    if (children > 0) parts.add('$children Child${children > 1 ? 'ren' : ''}');
    if (infants > 0) parts.add('$infants Infant${infants > 1 ? 's' : ''}');
    return parts.join(' · ');
  }

  String _getCityName(String code) {
    switch (code) {
      case 'AMS':
        return 'Amsterdam';
      case 'LON':
        return 'London';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryBlue.withValues(alpha: 0.08),
              blurRadius: 30,
            ),
          ],
        ),
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AirportPill(
                  code: origin,
                  city: _getCityName(origin),
                  alignRight: false,
                  onTap: onOriginTap,
                ),
                const SizedBox(width: AppSpacing.sm),
                const RouteDivider(),
                const SizedBox(width: AppSpacing.sm),
                AirportPill(
                  code: destination,
                  city: _getCityName(destination),
                  alignRight: true,
                  onTap: onDestinationTap,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            if (tripType == TripType.multicity)
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surfaceMuted,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.primaryBlue,
                      size: 20,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        'Multicity search coming soon',
                        style: AppTypography.textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else ...[
              InfoRow(
                icon: Icons.event_rounded,
                label: 'Departure',
                value: _formattedDate,
                onTap: onDateTap,
              ),
              if (tripType == TripType.roundTrip &&
                  onReturnDateTap != null) ...[
                const SizedBox(height: AppSpacing.md),
                InfoRow(
                  icon: Icons.event_available_rounded,
                  label: 'Return',
                  value: returnDate != null
                      ? DateFormat('EEE, d MMM yyyy').format(returnDate!)
                      : 'Select return date',
                  onTap: onReturnDateTap!,
                ),
              ],
            ],
            const SizedBox(height: AppSpacing.md),
            InfoRow(
              icon: Icons.people_rounded,
              label: 'Travelers',
              value: _travelersText,
              onTap: onTravelersTap,
            ),
            const SizedBox(height: AppSpacing.md),
            InfoRow(
              icon: Icons.airline_seat_legroom_normal_rounded,
              label: 'Cabin',
              value: cabinClass,
              onTap: onCabinTap,
            ),
            const SizedBox(height: AppSpacing.md),
            InfoRow(
              icon: Icons.attach_money_rounded,
              label: 'Currency',
              value: currency,
              onTap: onCurrencyTap,
            ),
          ],
        ),
      ),
    );
  }
}
