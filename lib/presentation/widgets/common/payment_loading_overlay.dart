import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

/// Simple splash-style payment processing overlay.
class PaymentLoadingOverlay extends StatefulWidget {
  const PaymentLoadingOverlay({
    super.key,
    required this.amount,
    required this.currencyCode,
    this.paymentMethod,
  });

  final double amount;
  final String currencyCode;
  final String? paymentMethod;

  @override
  State<PaymentLoadingOverlay> createState() => _PaymentLoadingOverlayState();
}

class _PaymentLoadingOverlayState extends State<PaymentLoadingOverlay>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _rotationController;
  late AnimationController _pulseController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // Fade in animation
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    // Rotation animation for circular indicator
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );

    // Pulse animation for card icon
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Start fade in
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _rotationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        color: Colors.black.withValues(alpha: 0.85),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Amount on top
              Text(
                '${widget.currencyCode} ${widget.amount.toStringAsFixed(2)}',
                style: AppTypography.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: AppSpacing.xl * 2),

              // Card icon with circular animation
              _AnimatedCardIcon(
                pulseAnimation: _pulseAnimation,
                rotationAnimation: _rotationAnimation,
              ),
              const SizedBox(height: AppSpacing.xl * 2),

              // Payment method text
              if (widget.paymentMethod != null) ...[
                Text(
                  widget.paymentMethod!,
                  style: AppTypography.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withValues(alpha: 0.9),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],

              // Processing text
              Text(
                'Processing...',
                style: AppTypography.textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Card icon with pulse and circular rotating indicator.
class _AnimatedCardIcon extends StatelessWidget {
  const _AnimatedCardIcon({
    required this.pulseAnimation,
    required this.rotationAnimation,
  });

  final Animation<double> pulseAnimation;
  final Animation<double> rotationAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([pulseAnimation, rotationAnimation]),
      builder: (context, child) {
        return SizedBox(
          width: 120,
          height: 120,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Circular rotating indicator
              Transform.rotate(
                angle: rotationAnimation.value * 2 * 3.14159,
                child: CustomPaint(
                  size: const Size(120, 120),
                  painter: _CircularProgressPainter(
                    progress: rotationAnimation.value,
                  ),
                ),
              ),
              // Card icon with pulse
              Transform.scale(
                scale: pulseAnimation.value,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryBlue.withValues(alpha: 0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.credit_card_rounded,
                    size: 36,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Custom painter for circular progress indicator.
class _CircularProgressPainter extends CustomPainter {
  _CircularProgressPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 5;

    // Background circle
    final backgroundPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Animated arc
    final progressPaint = Paint()
      ..color = AppColors.primaryBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    // Draw arc that rotates around
    final startAngle = -3.14159 / 2 + (progress * 2 * 3.14159);
    final sweepAngle = 1.5; // 90 degrees in radians

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
