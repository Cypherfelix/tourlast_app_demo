import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

typedef ValueChanged3<T1, T2, T3> = void Function(T1, T2, T3);

class TravelersSelectorSheet extends StatefulWidget {
  const TravelersSelectorSheet({
    super.key,
    required this.adults,
    required this.children,
    required this.infants,
    required this.onConfirm,
  });

  final int adults;
  final int children;
  final int infants;
  final ValueChanged3<int, int, int> onConfirm;

  @override
  State<TravelersSelectorSheet> createState() => _TravelersSelectorSheetState();
}

class _TravelersSelectorSheetState extends State<TravelersSelectorSheet> {
  late int _adults;
  late int _children;
  late int _infants;

  @override
  void initState() {
    super.initState();
    _adults = widget.adults;
    _children = widget.children;
    _infants = widget.infants;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: AppSpacing.md,
              bottom: AppSpacing.lg,
            ),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Text(
              'Select Travelers',
              style: AppTypography.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          _TravelerCounter(
            label: 'Adults',
            subtitle: '12+ years',
            count: _adults,
            min: 1,
            onIncrement: () => setState(() => _adults++),
            onDecrement: () =>
                setState(() => _adults = _adults > 1 ? _adults - 1 : 1),
          ),
          _TravelerCounter(
            label: 'Children',
            subtitle: '2-11 years',
            count: _children,
            min: 0,
            onIncrement: () => setState(() => _children++),
            onDecrement: () =>
                setState(() => _children = _children > 0 ? _children - 1 : 0),
          ),
          _TravelerCounter(
            label: 'Infants',
            subtitle: 'Under 2 years',
            count: _infants,
            min: 0,
            onIncrement: () => setState(() => _infants++),
            onDecrement: () =>
                setState(() => _infants = _infants > 0 ? _infants - 1 : 0),
          ),
          const SizedBox(height: AppSpacing.lg),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => widget.onConfirm(_adults, _children, _infants),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                ),
                child: const Text('Confirm'),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}

class _TravelerCounter extends StatelessWidget {
  const _TravelerCounter({
    required this.label,
    required this.subtitle,
    required this.count,
    required this.min,
    required this.onIncrement,
    required this.onDecrement,
  });

  final String label;
  final String subtitle;
  final int count;
  final int min;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(subtitle, style: AppTypography.textTheme.bodySmall),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: count > min ? onDecrement : null,
                icon: const Icon(Icons.remove_circle_outline),
                color: count > min
                    ? AppColors.primaryBlue
                    : AppColors.textTertiary,
              ),
              Container(
                width: 50,
                alignment: Alignment.center,
                child: Text(
                  '$count',
                  style: AppTypography.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                onPressed: onIncrement,
                icon: const Icon(Icons.add_circle_outline),
                color: AppColors.primaryBlue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
