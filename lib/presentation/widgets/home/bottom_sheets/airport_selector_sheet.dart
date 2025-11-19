import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class AirportSelectorSheet extends StatefulWidget {
  const AirportSelectorSheet({
    super.key,
    required this.airports,
    required this.selectedCode,
    required this.onSelect,
  });

  final List<Map<String, String>> airports;
  final String selectedCode;
  final ValueChanged<String> onSelect;

  @override
  State<AirportSelectorSheet> createState() => _AirportSelectorSheetState();
}

class _AirportSelectorSheetState extends State<AirportSelectorSheet> {
  String _searchQuery = '';

  List<Map<String, String>> get _filteredAirports {
    if (_searchQuery.isEmpty) return widget.airports;
    final query = _searchQuery.toLowerCase();
    return widget.airports.where((airport) {
      return airport['code']!.toLowerCase().contains(query) ||
          airport['city']!.toLowerCase().contains(query) ||
          airport['name']!.toLowerCase().contains(query);
    }).toList();
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
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search airports...',
                prefixIcon: const Icon(Icons.search_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _filteredAirports.length,
              itemBuilder: (context, index) {
                final airport = _filteredAirports[index];
                final isSelected = airport['code'] == widget.selectedCode;
                return ListTile(
                  leading: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryBlue.withValues(alpha: 0.1)
                          : AppColors.surfaceMuted,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        airport['code']!,
                        style: AppTypography.textTheme.titleMedium?.copyWith(
                          color: isSelected
                              ? AppColors.primaryBlue
                              : AppColors.textSecondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    airport['name']!,
                    style: AppTypography.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(airport['city']!),
                  trailing: isSelected
                      ? Icon(Icons.check_circle, color: AppColors.primaryBlue)
                      : null,
                  onTap: () => widget.onSelect(airport['code']!),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}
