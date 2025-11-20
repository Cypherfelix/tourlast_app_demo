import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/app_transitions.dart';
import '../../../data/models/flight/fare_itinerary.dart';
import '../../widgets/home/models/search_params.dart';
import 'booking_confirmation_screen.dart';

/// Payment screen for completing the booking transaction.
class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({
    super.key,
    required this.fareItinerary,
    required this.searchParams,
    required this.flightId,
    required this.totalAmount,
    required this.currencyCode,
  });

  final FareItinerary fareItinerary;
  final SearchParams searchParams;
  final String flightId;
  final double totalAmount;
  final String currencyCode;

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  PaymentMethod _selectedPaymentMethod = PaymentMethod.card;

  // Card details controllers
  final _cardNumberController = TextEditingController();
  final _cardHolderNameController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();

  // Mobile money controllers
  final _phoneNumberController = TextEditingController();

  bool _isProcessing = false;

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderNameController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _processPayment() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isProcessing = true);

    // Simulate payment processing
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      setState(() => _isProcessing = false);

      // Generate booking reference
      final bookingReference = _generateBookingReference();

      // Navigate to confirmation screen
      Navigator.of(context).pushReplacement(
        AppTransitions.slideFromRight(
          BookingConfirmationScreen(
            fareItinerary: widget.fareItinerary,
            searchParams: widget.searchParams,
            flightId: widget.flightId,
            totalAmount: widget.totalAmount,
            currencyCode: widget.currencyCode,
            bookingReference: bookingReference,
          ),
        ),
      );
    });
  }

  String _generateBookingReference() {
    // Generate a random booking reference (e.g., ABC123XY)
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = DateTime.now().millisecondsSinceEpoch;
    final reference = StringBuffer();

    for (int i = 0; i < 8; i++) {
      reference.write(chars[random % chars.length]);
    }

    return reference.toString();
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
          'Payment',
          style: AppTypography.textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
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
                    // Total Amount Summary
                    _AmountSummaryCard(
                      totalAmount: widget.totalAmount,
                      currencyCode: widget.currencyCode,
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Payment Method Selection
                    Text(
                      'Select Payment Method',
                      style: AppTypography.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _PaymentMethodSelector(
                      selectedMethod: _selectedPaymentMethod,
                      onMethodSelected: (method) {
                        setState(() => _selectedPaymentMethod = method);
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Payment Form
                    if (_selectedPaymentMethod == PaymentMethod.card)
                      _CardPaymentForm(
                        cardNumberController: _cardNumberController,
                        cardHolderNameController: _cardHolderNameController,
                        expiryDateController: _expiryDateController,
                        cvvController: _cvvController,
                      )
                    else if (_selectedPaymentMethod ==
                        PaymentMethod.mobileMoney)
                      _MobileMoneyForm(
                        phoneNumberController: _phoneNumberController,
                      ),

                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),

            // Pay Button
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
                    onPressed: _isProcessing ? null : _processPayment,
                    icon: _isProcessing
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const Icon(Icons.payment_rounded),
                    label: Text(
                      _isProcessing
                          ? 'Processing...'
                          : 'Pay ${widget.currencyCode} ${widget.totalAmount.toStringAsFixed(2)}',
                    ),
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

enum PaymentMethod { card, mobileMoney, bankTransfer }

/// Amount summary card
class _AmountSummaryCard extends StatelessWidget {
  const _AmountSummaryCard({
    required this.totalAmount,
    required this.currencyCode,
  });

  final double totalAmount;
  final String currencyCode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Amount',
                style: AppTypography.textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                '$currencyCode ${totalAmount.toStringAsFixed(2)}',
                style: AppTypography.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryBlue,
                ),
              ),
            ],
          ),
          Icon(
            Icons.receipt_long_rounded,
            size: 32,
            color: AppColors.primaryBlue,
          ),
        ],
      ),
    );
  }
}

/// Payment method selector
class _PaymentMethodSelector extends StatelessWidget {
  const _PaymentMethodSelector({
    required this.selectedMethod,
    required this.onMethodSelected,
  });

  final PaymentMethod selectedMethod;
  final ValueChanged<PaymentMethod> onMethodSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PaymentMethodChip(
          method: PaymentMethod.card,
          icon: Icons.credit_card_rounded,
          label: 'Credit/Debit Card',
          isSelected: selectedMethod == PaymentMethod.card,
          onTap: () => onMethodSelected(PaymentMethod.card),
        ),
        const SizedBox(height: AppSpacing.sm),
        _PaymentMethodChip(
          method: PaymentMethod.mobileMoney,
          icon: Icons.phone_android_rounded,
          label: 'Mobile Money',
          isSelected: selectedMethod == PaymentMethod.mobileMoney,
          onTap: () => onMethodSelected(PaymentMethod.mobileMoney),
        ),
        const SizedBox(height: AppSpacing.sm),
        _PaymentMethodChip(
          method: PaymentMethod.bankTransfer,
          icon: Icons.account_balance_rounded,
          label: 'Bank Transfer',
          isSelected: selectedMethod == PaymentMethod.bankTransfer,
          onTap: () => onMethodSelected(PaymentMethod.bankTransfer),
          isDisabled: true,
        ),
      ],
    );
  }
}

/// Payment method chip
class _PaymentMethodChip extends StatelessWidget {
  const _PaymentMethodChip({
    required this.method,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.isDisabled = false,
  });

  final PaymentMethod method;
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isDisabled ? 0.5 : 1.0,
      child: InkWell(
        onTap: isDisabled ? null : onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
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
          child: Row(
            children: [
              Icon(
                icon,
                size: 24,
                color: isSelected
                    ? AppColors.primaryBlue
                    : AppColors.textSecondary,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  label,
                  style: AppTypography.textTheme.bodyMedium?.copyWith(
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                    color: isSelected
                        ? AppColors.primaryBlue
                        : AppColors.textPrimary,
                  ),
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle_rounded,
                  size: 20,
                  color: AppColors.primaryBlue,
                ),
              if (isDisabled)
                Padding(
                  padding: const EdgeInsets.only(left: AppSpacing.sm),
                  child: Text(
                    'Coming Soon',
                    style: AppTypography.textTheme.labelSmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 10,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Card payment form
class _CardPaymentForm extends StatelessWidget {
  const _CardPaymentForm({
    required this.cardNumberController,
    required this.cardHolderNameController,
    required this.expiryDateController,
    required this.cvvController,
  });

  final TextEditingController cardNumberController;
  final TextEditingController cardHolderNameController;
  final TextEditingController expiryDateController;
  final TextEditingController cvvController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Card Details',
            style: AppTypography.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Card Number
          _CardTextField(
            controller: cardNumberController,
            label: 'Card Number',
            hint: '1234 5678 9012 3456',
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(19),
              CardNumberFormatter(),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Card number is required';
              }
              if (value.replaceAll(' ', '').length < 16) {
                return 'Please enter a valid card number';
              }
              return null;
            },
            prefixIcon: Icons.credit_card_rounded,
          ),
          const SizedBox(height: AppSpacing.md),

          // Card Holder Name
          _CardTextField(
            controller: cardHolderNameController,
            label: 'Card Holder Name',
            hint: 'John Doe',
            textCapitalization: TextCapitalization.words,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Card holder name is required';
              }
              return null;
            },
            prefixIcon: Icons.person_rounded,
          ),
          const SizedBox(height: AppSpacing.md),

          // Expiry Date and CVV Row
          Row(
            children: [
              Expanded(
                child: _CardTextField(
                  controller: expiryDateController,
                  label: 'Expiry Date',
                  hint: 'MM/YY',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(5),
                    ExpiryDateFormatter(),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    if (value.length < 5) {
                      return 'Invalid';
                    }
                    return null;
                  },
                  prefixIcon: Icons.calendar_today_rounded,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _CardTextField(
                  controller: cvvController,
                  label: 'CVV',
                  hint: '123',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    if (value.length < 3) {
                      return 'Invalid';
                    }
                    return null;
                  },
                  prefixIcon: Icons.lock_rounded,
                  obscureText: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Card text field
class _CardTextField extends StatelessWidget {
  const _CardTextField({
    required this.controller,
    required this.label,
    required this.hint,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.prefixIcon,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final IconData? prefixIcon;
  final bool obscureText;

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
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, size: 20, color: AppColors.textSecondary)
                : null,
          ),
          style: AppTypography.textTheme.bodyMedium,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization,
          obscureText: obscureText,
          validator: validator,
        ),
      ],
    );
  }
}

/// Mobile money form
class _MobileMoneyForm extends StatelessWidget {
  const _MobileMoneyForm({required this.phoneNumberController});

  final TextEditingController phoneNumberController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mobile Money Details',
            style: AppTypography.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _CardTextField(
            controller: phoneNumberController,
            label: 'Phone Number',
            hint: '254712345678',
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
            prefixIcon: Icons.phone_android_rounded,
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surfaceMuted,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 20,
                  color: AppColors.primaryBlue,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'You will receive a payment prompt on your phone',
                    style: AppTypography.textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
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

/// Card number formatter
class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(text[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

/// Expiry date formatter
class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll('/', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i == 2) {
        buffer.write('/');
      }
      buffer.write(text[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
