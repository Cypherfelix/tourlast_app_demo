import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_spacing.dart';
import '../../../../../core/theme/app_typography.dart';

/// Price range filter section with slider.
class PriceFilterSection extends StatefulWidget {
  const PriceFilterSection({
    super.key,
    this.minPrice,
    this.maxPrice,
    required this.onChanged,
  });

  final double? minPrice;
  final double? maxPrice;
  final void Function(double?, double?) onChanged;

  @override
  State<PriceFilterSection> createState() => _PriceFilterSectionState();
}

class _PriceFilterSectionState extends State<PriceFilterSection> {
  late RangeValues _rangeValues;
  late TextEditingController _minController;
  late TextEditingController _maxController;
  static const double _minPrice = 0;
  static const double _maxPrice = 10000;

  @override
  void initState() {
    super.initState();
    _rangeValues = RangeValues(
      widget.minPrice ?? _minPrice,
      widget.maxPrice ?? _maxPrice,
    );
    _minController = TextEditingController(
      text: widget.minPrice?.toStringAsFixed(0) ?? '',
    );
    _maxController = TextEditingController(
      text: widget.maxPrice?.toStringAsFixed(0) ?? '',
    );
  }

  @override
  void didUpdateWidget(PriceFilterSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.minPrice != oldWidget.minPrice ||
        widget.maxPrice != oldWidget.maxPrice) {
      _rangeValues = RangeValues(
        widget.minPrice ?? _minPrice,
        widget.maxPrice ?? _maxPrice,
      );
      _minController.text = widget.minPrice?.toStringAsFixed(0) ?? '';
      _maxController.text = widget.maxPrice?.toStringAsFixed(0) ?? '';
    }
  }

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    super.dispose();
  }

  void _onRangeChanged(RangeValues values) {
    setState(() {
      _rangeValues = values;
      _minController.text = values.start == _minPrice
          ? ''
          : values.start.toStringAsFixed(0);
      _maxController.text =
          values.end == _maxPrice ? '' : values.end.toStringAsFixed(0);
    });
    widget.onChanged(
      values.start == _minPrice ? null : values.start,
      values.end == _maxPrice ? null : values.end,
    );
  }

  void _onMinPriceChanged(String value) {
    final price = double.tryParse(value);
    if (price != null && price >= _minPrice && price <= _maxPrice) {
      final newMax = _rangeValues.end < price ? price : _rangeValues.end;
      final newValues = RangeValues(price, newMax);
      _onRangeChanged(newValues);
    } else if (value.isEmpty) {
      widget.onChanged(null, _rangeValues.end == _maxPrice ? null : _rangeValues.end);
    }
  }

  void _onMaxPriceChanged(String value) {
    final price = double.tryParse(value);
    if (price != null && price >= _minPrice && price <= _maxPrice) {
      final newMin = _rangeValues.start > price ? price : _rangeValues.start;
      final newValues = RangeValues(newMin, price);
      _onRangeChanged(newValues);
    } else if (value.isEmpty) {
      widget.onChanged(_rangeValues.start == _minPrice ? null : _rangeValues.start, null);
    }
  }

  String _formatPrice(double value) {
    if (value >= 1000) {
      return '\$${(value / 1000).toStringAsFixed(1)}k';
    }
    return '\$${value.toStringAsFixed(0)}';
  }

  @override
  Widget build(BuildContext context) {
    final hasFilter = widget.minPrice != null || widget.maxPrice != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.attach_money_rounded,
              size: 18,
              color: AppColors.primaryBlue,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'Price Range',
              style: AppTypography.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            if (hasFilter) ...[
              const SizedBox(width: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Active',
                  style: AppTypography.textTheme.labelSmall?.copyWith(
                    color: AppColors.primaryBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        RangeSlider(
          values: _rangeValues,
          min: _minPrice,
          max: _maxPrice,
          divisions: 100,
          labels: RangeLabels(
            _formatPrice(_rangeValues.start),
            _formatPrice(_rangeValues.end),
          ),
          onChanged: _onRangeChanged,
          activeColor: AppColors.primaryBlue,
          inactiveColor: AppColors.border,
        ),
        const SizedBox(height: AppSpacing.md),
        // Editable price inputs
        Row(
          children: [
            Expanded(
              child: _PriceInputField(
                controller: _minController,
                label: 'Min',
                hint: '0',
                onChanged: _onMinPriceChanged,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _PriceInputField(
                controller: _maxController,
                label: 'Max',
                hint: '10000',
                onChanged: _onMaxPriceChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PriceInputField extends StatelessWidget {
  const _PriceInputField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.textTheme.labelSmall?.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hint,
            prefixText: '\$ ',
            prefixStyle: AppTypography.textTheme.bodyMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            filled: true,
            fillColor: AppColors.surfaceMuted,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.primaryBlue,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
          ),
          style: AppTypography.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
