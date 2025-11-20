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
    this.selectedServices = const {},
    this.onServiceQuantityChanged,
  });

  final ValueChanged<double>? onTotalChanged;
  final Map<String, int> selectedServices;
  final ValueChanged2<String, int>? onServiceQuantityChanged;

  @override
  ConsumerState<ExtraServicesSection> createState() =>
      _ExtraServicesSectionState();
}

class _ExtraServicesSectionState
    extends ConsumerState<ExtraServicesSection> {
  double _totalExtraCost = 0.0;
  String _currencyCode = 'USD';

  Map<String, int> get _selectedServices => widget.selectedServices;

  @override
  void initState() {
    super.initState();
    _calculateTotal();
  }

  @override
  void didUpdateWidget(ExtraServicesSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedServices != widget.selectedServices) {
      _calculateTotal();
    }
  }

  void _updateServiceQuantity(String serviceId, int quantity) {
    widget.onServiceQuantityChanged?.call(serviceId, quantity);
    _calculateTotal();
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
              _BaggageSection(
                baggageOptions: data.dynamicBaggage,
                selectedServices: _selectedServices,
                onQuantityChanged: _updateServiceQuantity,
              ),
              const SizedBox(height: AppSpacing.md),
              _MealSection(
                mealOptions: data.dynamicMeal,
                selectedServices: _selectedServices,
                onQuantityChanged: _updateServiceQuantity,
              ),
              const SizedBox(height: AppSpacing.md),
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

class _BaggageSection extends StatefulWidget {
  const _BaggageSection({
    required this.baggageOptions,
    required this.selectedServices,
    required this.onQuantityChanged,
  });

  final List<dynamic> baggageOptions;
  final Map<String, int> selectedServices;
  final ValueChanged2<String, int> onQuantityChanged;

  @override
  State<_BaggageSection> createState() => _BaggageSectionState();
}

class _BaggageSectionState extends State<_BaggageSection> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final hasBaggage = widget.baggageOptions.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Row(
              children: [
                Icon(
                  Icons.luggage_rounded,
                  size: 18,
                  color: AppColors.primaryBlue,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    'Baggage',
                    style: AppTypography.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded) ...[
          const SizedBox(height: AppSpacing.md),
          if (hasBaggage)
            ...widget.baggageOptions.map((baggage) {
              // Handle DynamicBaggage type
              final services = baggage.services as List<List<dynamic>>;
              final firstGroup = services.firstOrNull ?? [];
              
              return Column(
                children: firstGroup.map((service) {
                  final extraService = service as ExtraService;
                  final quantity = widget.selectedServices[extraService.serviceId] ?? 0;

                  return _ServiceItem(
                    service: extraService,
                    quantity: quantity,
                    onQuantityChanged: (newQuantity) =>
                        widget.onQuantityChanged(extraService.serviceId, newQuantity),
                  );
                }).toList(),
              );
            })
          else
            _EmptyState(
              icon: Icons.luggage_rounded,
              message: 'No baggage options available',
            ),
        ],
      ],
    );
  }
}

class _MealSection extends StatefulWidget {
  const _MealSection({
    required this.mealOptions,
    required this.selectedServices,
    required this.onQuantityChanged,
  });

  final List<dynamic> mealOptions;
  final Map<String, int> selectedServices;
  final ValueChanged2<String, int> onQuantityChanged;

  @override
  State<_MealSection> createState() => _MealSectionState();
}

class _MealSectionState extends State<_MealSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final hasMeals = widget.mealOptions.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Row(
              children: [
                Icon(
                  Icons.restaurant_rounded,
                  size: 18,
                  color: AppColors.primaryBlue,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    'Meals',
                    style: AppTypography.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded) ...[
          const SizedBox(height: AppSpacing.md),
          if (hasMeals)
            // TODO: Implement meal items when meal model is available
            Text(
              'Meal options coming soon',
              style: AppTypography.textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            )
          else
            _EmptyState(
              icon: Icons.restaurant_rounded,
              message: 'No meal options available',
            ),
        ],
      ],
    );
  }
}

class _SeatSection extends StatefulWidget {
  const _SeatSection({
    required this.seatOptions,
    required this.selectedServices,
    required this.onQuantityChanged,
  });

  final List<dynamic> seatOptions;
  final Map<String, int> selectedServices;
  final ValueChanged2<String, int> onQuantityChanged;

  @override
  State<_SeatSection> createState() => _SeatSectionState();
}

class _SeatSectionState extends State<_SeatSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final hasSeats = widget.seatOptions.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Row(
              children: [
                Icon(
                  Icons.event_seat_rounded,
                  size: 18,
                  color: AppColors.primaryBlue,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    'Seats',
                    style: AppTypography.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded) ...[
          const SizedBox(height: AppSpacing.md),
          if (hasSeats)
            // TODO: Implement seat items when seat model is available
            Text(
              'Seat options coming soon',
              style: AppTypography.textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            )
          else
            _EmptyState(
              icon: Icons.event_seat_rounded,
              message: 'No seat options available',
            ),
        ],
      ],
    );
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

/// Empty state widget for sections with no options
class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.icon,
    required this.message,
  });

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.lg,
        horizontal: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: AppTypography.textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Typedef for callback with two parameters
typedef ValueChanged2<T1, T2> = void Function(T1 value1, T2 value2);

