import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../models/trip_type.dart';
import 'trip_type_chip.dart';

class TripTypeSelector extends StatelessWidget {
  const TripTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  final TripType selectedType;
  final ValueChanged<TripType> onTypeChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.08),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          TripTypeChip(
            label: 'One-way',
            isSelected: selectedType == TripType.oneWay,
            onTap: () => onTypeChanged(TripType.oneWay),
          ),
          TripTypeChip(
            label: 'Round Trip',
            isSelected: selectedType == TripType.roundTrip,
            onTap: () => onTypeChanged(TripType.roundTrip),
          ),
          TripTypeChip(
            label: 'Multicity',
            isSelected: selectedType == TripType.multicity,
            onTap: () => onTypeChanged(TripType.multicity),
          ),
        ],
      ),
    );
  }
}
