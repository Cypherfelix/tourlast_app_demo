import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../data/models/extra_service/extra_service.dart';
import '../../../../data/models/extra_service/extra_services_data.dart';
import '../../../providers/extra_service_providers.dart';

/// Extra services section allowing selection of baggage, meals, and seats.
class ExtraServicesSection extends ConsumerStatefulWidget {
  const ExtraServicesSection({
    super.key,
    this.onTotalChanged,
  });

  final ValueChanged<double>? onTotalChanged;

  @override
  ConsumerState<ExtraServicesSection> createState() =>
      _ExtraServicesSectionState();
}

class _ExtraServicesSectionState
    extends ConsumerState<ExtraServicesSection> {
  final Map<String, int> _selectedServices = {};
  double _totalExtraCost = 0.0;
  String _currencyCode = 'USD';

  @override
  void initState() {
    super.initState();
    _calculateTotal();
  }

  void _updateServiceQuantity(String serviceId, int quantity) {
    setState(() {
      if (quantity <= 0) {
        _selectedServices.remove(serviceId);
      } else {
        _selectedServices[serviceId] = quantity;
      }
      _calculateTotal();
    });
    widget.onTotalChanged?.call(_totalExtraCost);
  }

  void _calculateTotal() {
    // This will be calculated from the actual services data
    // For now, we'll update it when services are loaded
  }

  @override
  Widget build(BuildContext context) {
    final extraServicesAsync = ref.watch(extraServicesProvider);

    return extraServicesAsync.when(
      data: (response) {
        final result = response.extraServicesResponse.extraServicesResult;
        final data = result.extraServicesData;
        final hasServices = data.dynamicBaggage.isNotEmpty ||
            (data.dynamicMeal.isNotEmpty) ||
            (data.dynamicSeat.isNotEmpty);

        if (!hasServices) {
          return const SizedBox.shrink();
        }

        // Update currency from first service if available
        if (data.dynamicBaggage.isNotEmpty) {
          final firstService = data.dynamicBaggage.first.services.firstOrNull
              ?.firstOrNull;
          if (firstService != null) {
            _currencyCode = firstService.serviceCost.currencyCode;
          }
        }

        // Recalculate total with actual services
        _recalculateTotal(data);

        return _buildSection(
          context,
          'Extra Services',
          Column(
            children: [
              if (data.dynamicBaggage.isNotEmpty)
                _BaggageSection(
                  baggageOptions: data.dynamicBaggage,
                  selectedServices: _selectedServices,
                  onQuantityChanged: _updateServiceQuantity,
                ),
              if (data.dynamicBaggage.isNotEmpty &&
                  (data.dynamicMeal.isNotEmpty || data.dynamicSeat.isNotEmpty))
                const SizedBox(height: AppSpacing.lg),
              if (data.dynamicMeal.isNotEmpty)
                _MealSection(
                  mealOptions: data.dynamicMeal,
                  selectedServices: _selectedServices,
                  onQuantityChanged: _updateServiceQuantity,
                ),
              if (data.dynamicMeal.isNotEmpty && data.dynamicSeat.isNotEmpty)
                const SizedBox(height: AppSpacing.lg),
              if (data.dynamicSeat.isNotEmpty)
                _SeatSection(
                  seatOptions: data.dynamicSeat,
                  selectedServices: _selectedServices,
                  onQuantityChanged: _updateServiceQuantity,
                ),
              if (_selectedServices.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.lg),
                const Divider(),
                const SizedBox(height: AppSpacing.md),
                _TotalRow(
                  total: _totalExtraCost,
                  currencyCode: _currencyCode,
                ),
              ],
            ],
          ),
        );
      },
      loading: () => _buildSection(
        context,
        'Extra Services',
        const Center(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.xl),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      error: (error, stack) => _buildSection(
        context,
        'Extra Services',
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Text(
            'Unable to load extra services',
            style: AppTypography.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }

  void _recalculateTotal(ExtraServicesData data) {
    double total = 0.0;

    // Calculate from baggage
    for (final baggage in data.dynamicBaggage) {
      for (final serviceGroup in baggage.services) {
        for (final service in serviceGroup) {
          final quantity = _selectedServices[service.serviceId] ?? 0;
          if (quantity > 0) {
            total += service.serviceCost.amountValue * quantity;
          }
        }
      }
    }

    // TODO: Calculate from meals and seats when models are available

    setState(() {
      _totalExtraCost = total;
    });
    widget.onTotalChanged?.call(_totalExtraCost);
  }

  Widget _buildSection(BuildContext context, String title, Widget content) {
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
                title,
                style: AppTypography.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          content,
        ],
      ),
    );
  }
}

class _BaggageSection extends StatelessWidget {
  const _BaggageSection({
    required this.baggageOptions,
    required this.selectedServices,
    required this.onQuantityChanged,
  });

  final List<dynamic> baggageOptions;
  final Map<String, int> selectedServices;
  final ValueChanged2<String, int> onQuantityChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.luggage_rounded,
              size: 18,
              color: AppColors.primaryBlue,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              'Baggage',
              style: AppTypography.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        ...baggageOptions.map((baggage) {
          // Handle DynamicBaggage type
          final services = baggage.services as List<List<dynamic>>;
          final firstGroup = services.firstOrNull ?? [];
          
          return Column(
            children: firstGroup.map((service) {
              final extraService = service as ExtraService;
              final quantity = selectedServices[extraService.serviceId] ?? 0;

              return _ServiceItem(
                service: extraService,
                quantity: quantity,
                onQuantityChanged: (newQuantity) =>
                    onQuantityChanged(extraService.serviceId, newQuantity),
              );
            }).toList(),
          );
        }).toList(),
      ],
    );
  }
}

class _MealSection extends StatelessWidget {
  const _MealSection({
    required this.mealOptions,
    required this.selectedServices,
    required this.onQuantityChanged,
  });

  final List<dynamic> mealOptions;
  final Map<String, int> selectedServices;
  final ValueChanged2<String, int> onQuantityChanged;

  @override
  Widget build(BuildContext context) {
    // TODO: Implement when meal model is available
    return const SizedBox.shrink();
  }
}

class _SeatSection extends StatelessWidget {
  const _SeatSection({
    required this.seatOptions,
    required this.selectedServices,
    required this.onQuantityChanged,
  });

  final List<dynamic> seatOptions;
  final Map<String, int> selectedServices;
  final ValueChanged2<String, int> onQuantityChanged;

  @override
  Widget build(BuildContext context) {
    // TODO: Implement when seat model is available
    return const SizedBox.shrink();
  }
}

class _ServiceItem extends StatelessWidget {
  const _ServiceItem({
    required this.service,
    required this.quantity,
    required this.onQuantityChanged,
  });

  final ExtraService service;
  final int quantity;
  final ValueChanged<int> onQuantityChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: quantity > 0
            ? AppColors.primaryBlue.withValues(alpha: 0.05)
            : AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: quantity > 0
              ? AppColors.primaryBlue
              : AppColors.border,
          width: quantity > 0 ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.description,
                  style: AppTypography.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (service.fareDescription.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    service.fareDescription,
                    style: AppTypography.textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ],
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Text(
                      service.serviceCost.currencyCode,
                      style: AppTypography.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      service.serviceCost.amount,
                      style: AppTypography.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          // Quantity controls
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: quantity > 0
                      ? () => onQuantityChanged(quantity - 1)
                      : null,
                  icon: const Icon(Icons.remove_rounded, size: 18),
                  color: AppColors.textPrimary,
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                ),
                Container(
                  width: 40,
                  alignment: Alignment.center,
                  child: Text(
                    '$quantity',
                    style: AppTypography.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: quantity < service.maximumQuantity
                      ? () => onQuantityChanged(quantity + 1)
                      : null,
                  icon: const Icon(Icons.add_rounded, size: 18),
                  color: AppColors.primaryBlue,
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TotalRow extends StatelessWidget {
  const _TotalRow({
    required this.total,
    required this.currencyCode,
  });

  final double total;
  final String currencyCode;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Extra Services Total',
          style: AppTypography.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        Row(
          children: [
            Text(
              currencyCode,
              style: AppTypography.textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              total.toStringAsFixed(2),
              style: AppTypography.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primaryBlue,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Typedef for callback with two parameters
typedef ValueChanged2<T1, T2> = void Function(T1 value1, T2 value2);

