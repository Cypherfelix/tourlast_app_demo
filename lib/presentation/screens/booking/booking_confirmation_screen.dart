import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/flight/fare_itinerary.dart';
import '../../providers/flight_details_providers.dart';
import '../../screens/home/home_screen.dart';
import '../../widgets/flights/flight_card/airline_logo.dart';
import '../../widgets/home/models/search_params.dart';

/// Booking confirmation screen shown after successful payment.
class BookingConfirmationScreen extends ConsumerStatefulWidget {
  const BookingConfirmationScreen({
    super.key,
    required this.fareItinerary,
    required this.searchParams,
    required this.flightId,
    required this.totalAmount,
    required this.currencyCode,
    required this.bookingReference,
  });

  final FareItinerary fareItinerary;
  final SearchParams searchParams;
  final String flightId;
  final double totalAmount;
  final String currencyCode;
  final String bookingReference;

  @override
  ConsumerState<BookingConfirmationScreen> createState() =>
      _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState
    extends ConsumerState<BookingConfirmationScreen> {
  @override
  void initState() {
    super.initState();
    // Clear all booking-related state after booking is confirmed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _clearBookingState();
    });
  }

  void _clearBookingState() {
    // Reset flight details state completely for this booking
    try {
      ref.read(flightDetailsStateProvider(widget.flightId).notifier).reset();
    } catch (e) {
      // Provider might not exist, ignore
    }
  }

  void _navigateToHome() {
    // Clear all booking state before navigating
    _clearBookingState();

    // Navigate to home and clear navigation stack
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final segments = _getAllSegments();
    final firstSegment = segments.isNotEmpty ? segments.first : null;
    final lastSegment = segments.isNotEmpty ? segments.last : null;
    final airlineCode = firstSegment?.marketingAirlineCode ?? '';
    final departureCode = firstSegment?.departureAirportLocationCode ?? '';
    final arrivalCode = lastSegment?.arrivalAirportLocationCode ?? '';
    final departureTime = firstSegment?.departureDateTime ?? '';
    final arrivalTime = lastSegment?.arrivalDateTime ?? '';
    final flightNumber = firstSegment?.flightNumber ?? '';

    // Handle back button - navigate to home
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _navigateToHome();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppSpacing.xl),
              
              // Success Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  size: 50,
                  color: AppColors.success,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              
              // Success Message
              Text(
                'Booking Confirmed!',
                style: AppTypography.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Your flight has been successfully booked',
                style: AppTypography.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              
              // Booking Reference Card
                _BookingReferenceCard(
                  bookingReference: widget.bookingReference,
                ),
              const SizedBox(height: AppSpacing.lg),
              
              // Flight Details Card
              _FlightDetailsCard(
                airlineCode: airlineCode,
                departureCode: departureCode,
                arrivalCode: arrivalCode,
                departureTime: departureTime,
                arrivalTime: arrivalTime,
                flightNumber: flightNumber,
                  departureDate: widget.searchParams.departureDate,
              ),
              const SizedBox(height: AppSpacing.md),
              
              // Passenger Summary
                _PassengerSummaryCard(searchParams: widget.searchParams),
              const SizedBox(height: AppSpacing.md),
              
              // Payment Summary
              _PaymentSummaryCard(
                  totalAmount: widget.totalAmount,
                  currencyCode: widget.currencyCode,
              ),
              const SizedBox(height: AppSpacing.xl),
              
              // Action Buttons
              _ActionButtons(
                  bookingReference: widget.bookingReference,
                onViewBooking: () {
                  // TODO: Navigate to booking details
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('View booking feature coming soon'),
                      backgroundColor: AppColors.primaryBlue,
                    ),
                  );
                },
                onDownloadTicket: () {
                  // TODO: Download ticket
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Download ticket feature coming soon'),
                      backgroundColor: AppColors.primaryBlue,
                    ),
                  );
                },
                  onGoHome: _navigateToHome,
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
      ),
    );
  }

  List<dynamic> _getAllSegments() {
    final segments = <dynamic>[];
    for (final option
        in widget.fareItinerary.airItinerary.originDestinationOptions) {
      for (final item in option.originDestinationOption) {
        segments.add(item.flightSegment);
      }
    }
    return segments;
  }
}

/// Booking reference card
class _BookingReferenceCard extends StatelessWidget {
  const _BookingReferenceCard({required this.bookingReference});

  final String bookingReference;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryBlue.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Booking Reference',
            style: AppTypography.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            bookingReference,
            style: AppTypography.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.primaryBlue,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Save this reference number for your records',
            style: AppTypography.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Flight details card
class _FlightDetailsCard extends ConsumerWidget {
  const _FlightDetailsCard({
    required this.airlineCode,
    required this.departureCode,
    required this.arrivalCode,
    required this.departureTime,
    required this.arrivalTime,
    required this.flightNumber,
    required this.departureDate,
  });

  final String airlineCode;
  final String departureCode;
  final String arrivalCode;
  final String departureTime;
  final String arrivalTime;
  final String flightNumber;
  final DateTime departureDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.flight_takeoff_rounded,
                size: 20,
                color: AppColors.primaryBlue,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Flight Details',
                style: AppTypography.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Consumer(
                builder: (context, ref, child) {
                  final airlineLogoAsync = ref.watch(
                    airlineByCodeProvider(airlineCode),
                  );
                  return airlineLogoAsync.when(
                    data: (_) => AirlineLogo(
                      airlineCode: airlineCode,
                      width: 40,
                      height: 40,
                    ),
                    loading: () => const SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    error: (_, __) => Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceMuted,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.flight_rounded,
                        size: 20,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$departureCode → $arrivalCode',
                      style: AppTypography.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '$airlineCode $flightNumber',
                      style: AppTypography.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Departure',
                      style: AppTypography.textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      departureTime.length > 5
                          ? departureTime.substring(11, 16)
                          : departureTime,
                      style: AppTypography.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      departureCode,
                      style: AppTypography.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      DateFormat('EEE, d MMM yyyy').format(departureDate),
                      style: AppTypography.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_rounded,
                size: 20,
                color: AppColors.textSecondary,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Arrival',
                      style: AppTypography.textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      arrivalTime.length > 5
                          ? arrivalTime.substring(11, 16)
                          : arrivalTime,
                      style: AppTypography.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      arrivalCode,
                      style: AppTypography.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      DateFormat('EEE, d MMM yyyy').format(departureDate),
                      style: AppTypography.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Passenger summary card
class _PassengerSummaryCard extends StatelessWidget {
  const _PassengerSummaryCard({required this.searchParams});

  final SearchParams searchParams;

  @override
  Widget build(BuildContext context) {
    final totalPassengers =
        searchParams.adults + searchParams.children + searchParams.infants;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.people_rounded,
                size: 20,
                color: AppColors.primaryBlue,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Passengers',
                style: AppTypography.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Passengers',
                style: AppTypography.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '$totalPassengers',
                style: AppTypography.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cabin Class',
                style: AppTypography.textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                searchParams.cabinClass,
                style: AppTypography.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Payment summary card
class _PaymentSummaryCard extends StatelessWidget {
  const _PaymentSummaryCard({
    required this.totalAmount,
    required this.currencyCode,
  });

  final double totalAmount;
  final String currencyCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.payment_rounded,
                size: 20,
                color: AppColors.primaryBlue,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Payment Summary',
                style: AppTypography.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Amount Paid',
                style: AppTypography.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '$currencyCode ${totalAmount.toStringAsFixed(2)}',
                style: AppTypography.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Icon(
                Icons.check_circle_rounded,
                size: 16,
                color: AppColors.success,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                'Payment successful',
                style: AppTypography.textTheme.bodySmall?.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Action buttons
class _ActionButtons extends StatelessWidget {
  const _ActionButtons({
    required this.bookingReference,
    required this.onViewBooking,
    required this.onDownloadTicket,
    required this.onGoHome,
  });

  final String bookingReference;
  final VoidCallback onViewBooking;
  final VoidCallback onDownloadTicket;
  final VoidCallback onGoHome;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: onViewBooking,
            icon: const Icon(Icons.receipt_long_rounded),
            label: const Text('View Booking'),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onDownloadTicket,
            icon: const Icon(Icons.download_rounded),
            label: const Text('Download Ticket'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryBlue,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              side: BorderSide(color: AppColors.primaryBlue),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextButton(
          onPressed: onGoHome,
          child: Text(
            'Back to Home',
            style: AppTypography.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

