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
  static const double _minPrice = 0;
  static const double _maxPrice = 10000;

  @override
  void initState() {
    super.initState();
    _rangeValues = RangeValues(
      widget.minPrice ?? _minPrice,
      widget.maxPrice ?? _maxPrice,
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
    }
  }

  void _onRangeChanged(RangeValues values) {
    setState(() {
      _rangeValues = values;
    });
    widget.onChanged(
      values.start == _minPrice ? null : values.start,
      values.end == _maxPrice ? null : values.end,
    );
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
        const SizedBox(height: AppSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatPrice(_rangeValues.start),
              style: AppTypography.textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              _formatPrice(_rangeValues.end),
              style: AppTypography.textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
