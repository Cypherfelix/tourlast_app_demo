import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/app_transitions.dart';
import '../../../data/models/flight/fare_itinerary.dart';
import '../../providers/extra_service_providers.dart';
import '../../providers/flight_details_providers.dart';
import '../../widgets/flights/flight_card/airline_logo.dart';
import '../../widgets/home/models/search_params.dart';
import 'passenger_details_screen.dart';

/// Booking summary screen showing flight, passengers, extras, and price breakdown.
class BookingSummaryScreen extends ConsumerWidget {
  const BookingSummaryScreen({
    super.key,
    required this.fareItinerary,
    required this.searchParams,
    required this.flightId,
  });

  final FareItinerary fareItinerary;
  final SearchParams searchParams;
  final String flightId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flightDetailsState = ref.watch(flightDetailsStateProvider(flightId));
    final selectedServices = flightDetailsState.selectedServices;
    final extraServicesAsync = ref.watch(extraServicesProvider);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Booking Summary',
          style: AppTypography.textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Flight Information Section
                  _FlightInfoSection(fareItinerary: fareItinerary),
                  const SizedBox(height: AppSpacing.md),
                  
                  // Passenger Information Section
                  _PassengerInfoSection(searchParams: searchParams),
                  const SizedBox(height: AppSpacing.md),
                  
                  // Extra Services Section (if any selected)
                  if (selectedServices.isNotEmpty)
                    extraServicesAsync.when(
                      data: (response) => _ExtraServicesSummarySection(
                        selectedServices: selectedServices,
                        extraServicesData: response.extraServicesResponse
                            .extraServicesResult.extraServicesData,
                      ),
                      loading: () => const SizedBox.shrink(),
                      error: (_, __) => const SizedBox.shrink(),
                    ),
                  if (selectedServices.isNotEmpty)
                    const SizedBox(height: AppSpacing.md),
                  
                  // Price Breakdown Section
                  _PriceBreakdownSection(
                    fareItinerary: fareItinerary,
                    selectedServices: selectedServices,
                    extraServicesAsync: extraServicesAsync,
                    currency: searchParams.currency,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),
          
          // Proceed Button
          _ProceedButton(
            onPressed: () {
              // Navigate to passenger details entry screen
              Navigator.of(context).push(
                AppTransitions.slideFromRight(
                  PassengerDetailsScreen(
                    fareItinerary: fareItinerary,
                    searchParams: searchParams,
                    flightId: flightId,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Flight information section
class _FlightInfoSection extends ConsumerWidget {
  const _FlightInfoSection({required this.fareItinerary});

  final FareItinerary fareItinerary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final segments = _getAllSegments();
    final firstSegment = segments.isNotEmpty ? segments.first : null;
    final lastSegment = segments.isNotEmpty ? segments.last : null;
    final airlineCode = firstSegment?.marketingAirlineCode ?? '';
    final departureCode = firstSegment?.departureAirportLocationCode ?? '';
    final arrivalCode = lastSegment?.arrivalAirportLocationCode ?? '';
    final departureTime = firstSegment?.departureDateTime ?? '';
    final arrivalTime = lastSegment?.arrivalDateTime ?? '';
    final flightNumber = firstSegment?.flightNumber ?? '';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
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
              // Airline Logo
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
                      'Flight $airlineCode $flightNumber',
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
                child: _TimeInfo(
                  label: 'Departure',
                  time: departureTime,
                  code: departureCode,
                ),
              ),
              Icon(
                Icons.arrow_forward_rounded,
                size: 16,
                color: AppColors.textSecondary,
              ),
              Expanded(
                child: _TimeInfo(
                  label: 'Arrival',
                  time: arrivalTime,
                  code: arrivalCode,
                  isRight: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<dynamic> _getAllSegments() {
    final segments = <dynamic>[];
    for (final option in fareItinerary.airItinerary.originDestinationOptions) {
      for (final item in option.originDestinationOption) {
        segments.add(item.flightSegment);
      }
    }
    return segments;
  }
}

/// Time information widget
class _TimeInfo extends StatelessWidget {
  const _TimeInfo({
    required this.label,
    required this.time,
    required this.code,
    this.isRight = false,
  });

  final String label;
  final String time;
  final String code;
  final bool isRight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.textTheme.labelSmall?.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          time.length > 5 ? time.substring(11, 16) : time,
          style: AppTypography.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          code,
          style: AppTypography.textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

/// Passenger information section
class _PassengerInfoSection extends StatelessWidget {
  const _PassengerInfoSection({required this.searchParams});

  final SearchParams searchParams;

  @override
  Widget build(BuildContext context) {
    final totalPassengers = searchParams.adults + searchParams.children + searchParams.infants;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
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
          _PassengerRow(
            label: 'Adults',
            count: searchParams.adults,
          ),
          if (searchParams.children > 0) ...[
            const SizedBox(height: AppSpacing.sm),
            _PassengerRow(
              label: 'Children',
              count: searchParams.children,
            ),
          ],
          if (searchParams.infants > 0) ...[
            const SizedBox(height: AppSpacing.sm),
            _PassengerRow(
              label: 'Infants',
              count: searchParams.infants,
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          const Divider(),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Passengers',
                style: AppTypography.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '$totalPassengers',
                style: AppTypography.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
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

/// Passenger row widget
class _PassengerRow extends StatelessWidget {
  const _PassengerRow({
    required this.label,
    required this.count,
  });

  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.textTheme.bodyMedium?.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          '$count',
          style: AppTypography.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

/// Extra services summary section
class _ExtraServicesSummarySection extends StatelessWidget {
  const _ExtraServicesSummarySection({
    required this.selectedServices,
    required this.extraServicesData,
  });

  final Map<String, int> selectedServices;
  final dynamic extraServicesData;

  @override
  Widget build(BuildContext context) {
    final servicesList = <_ServiceSummary>[];

    // Extract selected services from baggage
    for (final baggage in extraServicesData.dynamicBaggage) {
      for (final serviceGroup in baggage.services) {
        for (final service in serviceGroup) {
          final quantity = selectedServices[service.serviceId] ?? 0;
          if (quantity > 0) {
            servicesList.add(_ServiceSummary(
              name: service.description,
              quantity: quantity,
              price: service.serviceCost.amountValue,
              currency: service.serviceCost.currencyCode,
            ));
          }
        }
      }
    }

    if (servicesList.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
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
                Icons.add_circle_outline_rounded,
                size: 20,
                color: AppColors.primaryBlue,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Extra Services',
                style: AppTypography.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ...servicesList.map((service) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${service.name} x${service.quantity}',
                        style: AppTypography.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Text(
                      '${service.currency} ${(service.price * service.quantity).toStringAsFixed(2)}',
                      style: AppTypography.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

/// Service summary model
class _ServiceSummary {
  const _ServiceSummary({
    required this.name,
    required this.quantity,
    required this.price,
    required this.currency,
  });

  final String name;
  final int quantity;
  final double price;
  final String currency;
}

/// Price breakdown section
class _PriceBreakdownSection extends ConsumerWidget {
  const _PriceBreakdownSection({
    required this.fareItinerary,
    required this.selectedServices,
    required this.extraServicesAsync,
    required this.currency,
  });

  final FareItinerary fareItinerary;
  final Map<String, int> selectedServices;
  final AsyncValue<dynamic> extraServicesAsync;
  final String currency;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fareInfo = fareItinerary.airItineraryFareInfo;
    final baseFare = fareInfo.itinTotalFares.baseFare.amountValue;
    final taxes = fareInfo.itinTotalFares.totalTax.amountValue;
    final totalFare = fareInfo.itinTotalFares.totalFare.amountValue;
    final currencyCode = fareInfo.itinTotalFares.totalFare.currencyCode;

    double extraServicesTotal = 0.0;

    extraServicesAsync.whenData((response) {
      final data = response.extraServicesResponse.extraServicesResult.extraServicesData;
      for (final baggage in data.dynamicBaggage) {
        for (final serviceGroup in baggage.services) {
          for (final service in serviceGroup) {
            final quantity = selectedServices[service.serviceId] ?? 0;
            if (quantity > 0) {
              extraServicesTotal += service.serviceCost.amountValue * quantity;
            }
          }
        }
      }
    });

    final grandTotal = totalFare + extraServicesTotal;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
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
                Icons.receipt_long_rounded,
                size: 20,
                color: AppColors.primaryBlue,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Price Breakdown',
                style: AppTypography.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _PriceRow(
            label: 'Base Fare',
            amount: baseFare,
            currency: currencyCode,
          ),
          const SizedBox(height: AppSpacing.sm),
          _PriceRow(
            label: 'Taxes & Fees',
            amount: taxes,
            currency: currencyCode,
          ),
          if (extraServicesTotal > 0) ...[
            const SizedBox(height: AppSpacing.sm),
            _PriceRow(
              label: 'Extra Services',
              amount: extraServicesTotal,
              currency: currencyCode,
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          const Divider(),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: AppTypography.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '$currencyCode ${grandTotal.toStringAsFixed(2)}',
                style: AppTypography.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryBlue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Price row widget
class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.label,
    required this.amount,
    required this.currency,
  });

  final String label;
  final double amount;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.textTheme.bodyMedium?.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          '$currency ${amount.toStringAsFixed(2)}',
          style: AppTypography.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

/// Proceed button
class _ProceedButton extends StatelessWidget {
  const _ProceedButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: onPressed,
            icon: const Icon(Icons.arrow_forward_rounded),
            label: const Text('Proceed to Booking'),
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
      ),
    );
  }
}

