import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/flight/air_itinerary_fare_info.dart';
import '../../../../data/models/flight/fare_breakdown.dart';
import '../../../../data/models/common/money.dart';

/// Expandable fare breakdown card showing pricing details.
class FareBreakdownCard extends StatefulWidget {
  const FareBreakdownCard({super.key, required this.fareInfo});

  final AirItineraryFareInfo fareInfo;

  @override
  State<FareBreakdownCard> createState() => _FareBreakdownCardState();
}

class _FareBreakdownCardState extends State<FareBreakdownCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final totalFare = widget.fareInfo.itinTotalFares.totalFare;
    final fareBreakdowns = widget.fareInfo.fareBreakdown;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
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
        children: [
          // Header with total price
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Fare Breakdown',
                          style: AppTypography.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Row(
                          children: [
                            Text(
                              totalFare.currencyCode,
                              style: AppTypography.textTheme.bodySmall
                                  ?.copyWith(color: AppColors.textSecondary),
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              totalFare.amount,
                              style: AppTypography.textTheme.titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryBlue,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
          // Expandable breakdown
          if (_isExpanded) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Fare breakdown by passenger type
                  ...fareBreakdowns.map(
                    (breakdown) =>
                        _PassengerFareBreakdown(breakdown: breakdown),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const Divider(),
                  const SizedBox(height: AppSpacing.md),
                  // Total summary
                  _TotalSummary(
                    totalFare: totalFare,
                    fareBreakdowns: fareBreakdowns,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PassengerFareBreakdown extends StatelessWidget {
  const _PassengerFareBreakdown({required this.breakdown});

  final FareBreakdown breakdown;

  @override
  Widget build(BuildContext context) {
    final passengerTypeCode = breakdown.passengerTypeQuantity.code;
    final quantity = breakdown.passengerTypeQuantity.quantity;
    final passengerTypeLabel = _getPassengerTypeLabel(
      passengerTypeCode,
      quantity,
    );
    final passengerFare = breakdown.passengerFare;
    final baseFare = passengerFare.baseFare;
    final totalTax = _calculateTotalTax(passengerFare.taxes);
    final total = passengerFare.totalFare;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            passengerTypeLabel,
            style: AppTypography.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Padding(
            padding: const EdgeInsets.only(left: AppSpacing.md),
            child: Column(
              children: [
                _FareRow(label: 'Base Fare', amount: baseFare),
                _FareRow(label: 'Taxes', amount: totalTax),
                const Divider(),
                _FareRow(label: 'Total', amount: total, isTotal: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getPassengerTypeLabel(String code, int quantity) {
    String label;
    switch (code.toUpperCase()) {
      case 'ADT':
        label = 'Per Adult';
        break;
      case 'CHD':
      case 'CH':
        label = 'Per Child';
        break;
      case 'INF':
      case 'IN':
        label = 'Per Infant';
        break;
      default:
        label = 'Per $code';
    }
    if (quantity > 1) {
      return '$label (x$quantity)';
    }
    return label;
  }

  Money _calculateTotalTax(List<dynamic> taxes) {
    if (taxes.isEmpty) {
      return const Money(amount: '0', currencyCode: 'USD', decimalPlaces: null);
    }

    // Sum all tax amounts
    double totalTaxAmount = 0;
    String currencyCode = 'USD';

    for (final tax in taxes) {
      try {
        final amount = tax.amount.replaceAll(',', '');
        totalTaxAmount += double.parse(amount);
        currencyCode = tax.currencyCode;
      } catch (e) {
        // Skip invalid tax entries
      }
    }

    return Money(
      amount: totalTaxAmount.toStringAsFixed(2),
      currencyCode: currencyCode,
      decimalPlaces: null,
    );
  }
}

class _FareRow extends StatelessWidget {
  const _FareRow({
    required this.label,
    required this.amount,
    this.isTotal = false,
  });

  final String label;
  final Money amount;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTypography.textTheme.bodyMedium?.copyWith(
              color: isTotal ? AppColors.textPrimary : AppColors.textSecondary,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
          Row(
            children: [
              Text(
                amount.currencyCode,
                style: AppTypography.textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                amount.amount,
                style: AppTypography.textTheme.bodyMedium?.copyWith(
                  color: isTotal
                      ? AppColors.primaryBlue
                      : AppColors.textPrimary,
                  fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TotalSummary extends StatelessWidget {
  const _TotalSummary({required this.totalFare, required this.fareBreakdowns});

  final Money totalFare;
  final List<FareBreakdown> fareBreakdowns;

  double _calculateTotalTax(List<dynamic> taxes) {
    if (taxes.isEmpty) {
      return 0.00;
    }

    // Sum all tax amounts
    double totalTaxAmount = 0;

    for (final tax in taxes) {
      try {
        final amount = tax.amount.replaceAll(',', '');
        totalTaxAmount += double.parse(amount);
      } catch (e) {
        // Skip invalid tax entries
      }
    }

    return totalTaxAmount.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total base fare and taxes
    double totalBaseFare = 0;
    double totalTaxes = 0;

    for (final breakdown in fareBreakdowns) {
      try {
        final passengerFare = breakdown.passengerFare;
        final quantity = breakdown.passengerTypeQuantity.quantity;

        totalBaseFare +=
            double.parse(passengerFare.baseFare.amount.replaceAll(',', '')) *
            quantity;

        // Calculate total tax for this breakdown
        totalTaxes += _calculateTotalTax(passengerFare.taxes);
      } catch (e) {
        // Skip invalid amounts
      }
    }

    print('totalTaxes: $totalTaxes');

    final currencyCode = totalFare.currencyCode;

    return Column(
      children: [
        _FareRow(
          label: 'Total Base Fare',
          amount: Money(
            amount: totalBaseFare.toStringAsFixed(2),
            currencyCode: currencyCode,
            decimalPlaces: null,
          ),
        ),
        _FareRow(
          label: 'Total Taxes',
          amount: Money(
            amount: totalTaxes.toStringAsFixed(2),
            currencyCode: currencyCode,
            decimalPlaces: null,
          ),
        ),
        const Divider(),
        _FareRow(label: 'Total Price', amount: totalFare, isTotal: true),
      ],
    );
  }
}
