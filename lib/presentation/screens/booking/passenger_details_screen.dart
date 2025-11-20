import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/flight/fare_itinerary.dart';
import '../../models/passenger_info.dart';
import '../../widgets/home/models/search_params.dart';

/// Passenger details entry screen for collecting passenger information.
class PassengerDetailsScreen extends ConsumerStatefulWidget {
  const PassengerDetailsScreen({
    super.key,
    required this.fareItinerary,
    required this.searchParams,
    required this.flightId,
  });

  final FareItinerary fareItinerary;
  final SearchParams searchParams;
  final String flightId;

  @override
  ConsumerState<PassengerDetailsScreen> createState() =>
      _PassengerDetailsScreenState();
}

class _PassengerDetailsScreenState
    extends ConsumerState<PassengerDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<PassengerInfo> _passengers = [];
  final Map<int, Map<String, TextEditingController>> _controllers = {};
  final Map<int, DateTime?> _dateOfBirths = {};
  final Map<int, String?> _genders = {};

  @override
  void initState() {
    super.initState();
    _initializePassengers();
  }

  void _initializePassengers() {
    int index = 0;

    // Add adults
    for (int i = 0; i < widget.searchParams.adults; i++) {
      _passengers.add(
        PassengerInfo(
          type: PassengerType.adult,
          firstName: '',
          lastName: '',
          dateOfBirth: DateTime.now().subtract(const Duration(days: 365 * 25)),
        ),
      );
      _initializeControllers(index);
      index++;
    }

    // Add children
    for (int i = 0; i < widget.searchParams.children; i++) {
      _passengers.add(
        PassengerInfo(
          type: PassengerType.child,
          firstName: '',
          lastName: '',
          dateOfBirth: DateTime.now().subtract(const Duration(days: 365 * 10)),
        ),
      );
      _initializeControllers(index);
      index++;
    }

    // Add infants
    for (int i = 0; i < widget.searchParams.infants; i++) {
      _passengers.add(
        PassengerInfo(
          type: PassengerType.infant,
          firstName: '',
          lastName: '',
          dateOfBirth: DateTime.now().subtract(const Duration(days: 365)),
        ),
      );
      _initializeControllers(index);
      index++;
    }
  }

  void _initializeControllers(int index) {
    _controllers[index] = {
      'firstName': TextEditingController(),
      'lastName': TextEditingController(),
      'middleName': TextEditingController(),
      'email': TextEditingController(),
      'phoneNumber': TextEditingController(),
      'passportNumber': TextEditingController(),
      'nationality': TextEditingController(text: 'Kenya'), // Default to Kenya
    };
    _dateOfBirths[index] = null;
    _genders[index] = null;
  }

  @override
  void dispose() {
    for (final controllers in _controllers.values) {
      for (final controller in controllers.values) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  Future<void> _selectDateOfBirth(int index) async {
    final initialDate =
        _dateOfBirths[index] ??
        DateTime.now().subtract(const Duration(days: 365 * 25));
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryBlue,
              onPrimary: Colors.white,
              surface: AppColors.surface,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dateOfBirths[index] = picked;
      });
    }
  }

  void _selectGender(int index, String gender) {
    setState(() {
      _genders[index] = gender;
    });
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(
              Icons.info_outline_rounded,
              color: AppColors.primaryBlue,
              size: 24,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'Quick Fill',
              style: AppTypography.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: Text(
          'Fill all passenger forms with demo data for quick testing?',
          style: AppTypography.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTypography.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _prefillAllForms();
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Pre-fill All'),
          ),
        ],
      ),
    );
  }

  void _prefillAllForms() {
    final demoData = [
      {
        'firstName': 'John',
        'lastName': 'Doe',
        'middleName': 'Michael',
        'email': 'john.doe@example.com',
        'phoneNumber': '254712345678',
        'passportNumber': 'A12345678',
        'nationality': 'Kenya',
        'gender': 'Male',
        'dateOfBirth': DateTime.now().subtract(const Duration(days: 365 * 30)),
      },
      {
        'firstName': 'Jane',
        'lastName': 'Smith',
        'middleName': 'Elizabeth',
        'email': 'jane.smith@example.com',
        'phoneNumber': '254723456789',
        'passportNumber': 'B87654321',
        'nationality': 'Kenya',
        'gender': 'Female',
        'dateOfBirth': DateTime.now().subtract(const Duration(days: 365 * 28)),
      },
      {
        'firstName': 'David',
        'lastName': 'Johnson',
        'middleName': 'Robert',
        'email': 'david.johnson@example.com',
        'phoneNumber': '254734567890',
        'passportNumber': 'C11223344',
        'nationality': 'Kenya',
        'gender': 'Male',
        'dateOfBirth': DateTime.now().subtract(const Duration(days: 365 * 25)),
      },
    ];

    setState(() {
      for (int i = 0; i < _passengers.length; i++) {
        final data = demoData[i % demoData.length];
        final controllers = _controllers[i]!;

        // Fill text fields
        controllers['firstName']!.text = data['firstName'] as String;
        controllers['lastName']!.text = data['lastName'] as String;
        controllers['middleName']!.text = data['middleName'] as String;
        controllers['email']!.text = data['email'] as String;
        controllers['phoneNumber']!.text = data['phoneNumber'] as String;
        controllers['passportNumber']!.text = data['passportNumber'] as String;
        controllers['nationality']!.text = data['nationality'] as String;

        // Set date of birth
        _dateOfBirths[i] = data['dateOfBirth'] as DateTime;

        // Set gender
        _genders[i] = data['gender'] as String;

        // Adjust date of birth based on passenger type
        if (_passengers[i].type == PassengerType.child) {
          _dateOfBirths[i] = DateTime.now().subtract(
            const Duration(days: 365 * 10),
          );
        } else if (_passengers[i].type == PassengerType.infant) {
          _dateOfBirths[i] = DateTime.now().subtract(const Duration(days: 365));
        }
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('All forms pre-filled with demo data'),
        backgroundColor: AppColors.primaryBlue,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  bool _validateForm() {
    if (!_formKey.currentState!.validate()) {
      return false;
    }

    for (int i = 0; i < _passengers.length; i++) {
      if (_dateOfBirths[i] == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please select date of birth for ${_getPassengerLabel(i)}',
            ),
            backgroundColor: AppColors.error,
          ),
        );
        return false;
      }
    }

    return true;
  }

  String _getPassengerLabel(int index) {
    final passenger = _passengers[index];
    final type = passenger.type == PassengerType.adult
        ? 'Adult ${index + 1}'
        : passenger.type == PassengerType.child
        ? 'Child ${index - widget.searchParams.adults + 1}'
        : 'Infant ${index - widget.searchParams.adults - widget.searchParams.children + 1}';
    return type;
  }

  void _submitForm() {
    if (!_validateForm()) {
      return;
    }

    // TODO: Save passenger data and navigate to payment
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Passenger details saved. Proceeding to payment...'),
        backgroundColor: AppColors.primaryBlue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Passenger Details',
          style: AppTypography.textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline_rounded),
            tooltip: 'Help & Quick Fill',
            onPressed: _showHelpDialog,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter passenger information',
                      style: AppTypography.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Please provide details for all ${_passengers.length} passenger${_passengers.length > 1 ? 's' : ''}',
                      style: AppTypography.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    ...List.generate(_passengers.length, (index) {
                      return _PassengerFormCard(
                        index: index,
                        passenger: _passengers[index],
                        controllers: _controllers[index]!,
                        dateOfBirth: _dateOfBirths[index],
                        gender: _genders[index],
                        onDateOfBirthTap: () => _selectDateOfBirth(index),
                        onGenderSelected: (gender) =>
                            _selectGender(index, gender),
                        passengerLabel: _getPassengerLabel(index),
                      );
                    }),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),
            // Continue Button
            Container(
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
                    onPressed: _submitForm,
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: const Text('Continue to Payment'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.md,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PassengerFormCard extends StatelessWidget {
  const _PassengerFormCard({
    required this.index,
    required this.passenger,
    required this.controllers,
    required this.dateOfBirth,
    required this.gender,
    required this.onDateOfBirthTap,
    required this.onGenderSelected,
    required this.passengerLabel,
  });

  final int index;
  final PassengerInfo passenger;
  final Map<String, TextEditingController> controllers;
  final DateTime? dateOfBirth;
  final String? gender;
  final VoidCallback onDateOfBirthTap;
  final ValueChanged<String> onGenderSelected;
  final String passengerLabel;

  @override
  Widget build(BuildContext context) {
    final isInfant = passenger.type == PassengerType.infant;

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
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
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  passengerLabel,
                  style: AppTypography.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
              const Spacer(),
              Icon(
                passenger.type == PassengerType.adult
                    ? Icons.person_rounded
                    : passenger.type == PassengerType.child
                    ? Icons.child_care_rounded
                    : Icons.child_friendly_rounded,
                size: 20,
                color: AppColors.textSecondary,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          // First Name
          _TextField(
            controller: controllers['firstName']!,
            label: 'First Name',
            hint: 'Enter first name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'First name is required';
              }
              return null;
            },
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: AppSpacing.md),
          // Last Name
          _TextField(
            controller: controllers['lastName']!,
            label: 'Last Name',
            hint: 'Enter last name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Last name is required';
              }
              return null;
            },
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: AppSpacing.md),
          // Middle Name (Optional)
          _TextField(
            controller: controllers['middleName']!,
            label: 'Middle Name (Optional)',
            hint: 'Enter middle name',
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: AppSpacing.md),
          // Date of Birth
          _DateField(
            label: 'Date of Birth',
            date: dateOfBirth,
            onTap: onDateOfBirthTap,
            validator: (value) {
              if (dateOfBirth == null) {
                return 'Date of birth is required';
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.md),
          // Gender
          _GenderSelector(
            label: 'Gender',
            selectedGender: gender,
            onGenderSelected: onGenderSelected,
            validator: (value) {
              if (gender == null) {
                return 'Gender is required';
              }
              return null;
            },
          ),
          if (!isInfant) ...[
            const SizedBox(height: AppSpacing.md),
            // Email
            _TextField(
              controller: controllers['email']!,
              label: 'Email',
              hint: 'Enter email address',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.md),
            // Phone Number
            _TextField(
              controller: controllers['phoneNumber']!,
              label: 'Phone Number',
              hint: 'Enter phone number',
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phone number is required';
                }
                if (value.length < 10) {
                  return 'Please enter a valid phone number';
                }
                return null;
              },
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          // Passport Number (Optional for domestic, required for international)
          _TextField(
            controller: controllers['passportNumber']!,
            label: 'Passport Number (Optional)',
            hint: 'Enter passport number',
            textCapitalization: TextCapitalization.characters,
          ),
          const SizedBox(height: AppSpacing.md),
          // Nationality (Optional)
          _TextField(
            controller: controllers['nationality']!,
            label: 'Nationality (Optional)',
            hint: 'Enter nationality',
            textCapitalization: TextCapitalization.words,
          ),
        ],
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    required this.controller,
    required this.label,
    required this.hint,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTypography.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
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
              borderSide: BorderSide(color: AppColors.primaryBlue, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.error, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
          ),
          style: AppTypography.textTheme.bodyMedium,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization,
          validator: validator,
        ),
      ],
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField({
    required this.label,
    required this.date,
    required this.onTap,
    this.validator,
  });

  final String label;
  final DateTime? date;
  final VoidCallback onTap;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: AppColors.surfaceMuted,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: validator != null && date == null
                    ? AppColors.error
                    : AppColors.border,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    date != null
                        ? DateFormat('dd MMM yyyy').format(date!)
                        : 'Select date of birth',
                    style: AppTypography.textTheme.bodyMedium?.copyWith(
                      color: date != null
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
                Icon(
                  Icons.calendar_today_rounded,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
        if (validator != null && date == null)
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.xs,
              left: AppSpacing.xs,
            ),
            child: Text(
              'Date of birth is required',
              style: AppTypography.textTheme.bodySmall?.copyWith(
                color: AppColors.error,
              ),
            ),
          ),
      ],
    );
  }
}

class _GenderSelector extends StatelessWidget {
  const _GenderSelector({
    required this.label,
    required this.selectedGender,
    required this.onGenderSelected,
    this.validator,
  });

  final String label;
  final String? selectedGender;
  final ValueChanged<String> onGenderSelected;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: [
            Expanded(
              child: _GenderChip(
                label: 'Male',
                isSelected: selectedGender == 'Male',
                onTap: () => onGenderSelected('Male'),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _GenderChip(
                label: 'Female',
                isSelected: selectedGender == 'Female',
                onTap: () => onGenderSelected('Female'),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _GenderChip(
                label: 'Other',
                isSelected: selectedGender == 'Other',
                onTap: () => onGenderSelected('Other'),
              ),
            ),
          ],
        ),
        if (validator != null && selectedGender == null)
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.xs,
              left: AppSpacing.xs,
            ),
            child: Text(
              'Gender is required',
              style: AppTypography.textTheme.bodySmall?.copyWith(
                color: AppColors.error,
              ),
            ),
          ),
      ],
    );
  }
}

class _GenderChip extends StatelessWidget {
  const _GenderChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryBlue.withValues(alpha: 0.1)
              : AppColors.surfaceMuted,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTypography.textTheme.bodyMedium?.copyWith(
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isSelected ? AppColors.primaryBlue : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
