import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';

/// Shimmer loading placeholder for flight card.
class FlightCardShimmer extends StatefulWidget {
  const FlightCardShimmer({super.key, this.animationDelay = Duration.zero});

  final Duration animationDelay;

  @override
  State<FlightCardShimmer> createState() => _FlightCardShimmerState();
}

class _FlightCardShimmerState extends State<FlightCardShimmer>
    with TickerProviderStateMixin {
  late AnimationController _shimmerController;
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    if (widget.animationDelay == Duration.zero) {
      _fadeController.forward();
    } else {
      Future.delayed(widget.animationDelay, () {
        if (mounted) {
          _fadeController.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeController,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border.withValues(alpha: 0.6)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  _ShimmerBox(
                    controller: _shimmerController,
                    width: 56,
                    height: 56,
                    borderRadius: 12,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ShimmerBox(
                          controller: _shimmerController,
                          width: 120,
                          height: 16,
                          delay: 0.1,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        _ShimmerBox(
                          controller: _shimmerController,
                          width: 80,
                          height: 12,
                          delay: 0.2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              // Route
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ShimmerBox(
                          controller: _shimmerController,
                          width: 60,
                          height: 24,
                          delay: 0.3,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        _ShimmerBox(
                          controller: _shimmerController,
                          width: 40,
                          height: 16,
                          delay: 0.4,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(height: 1, width: 100, color: AppColors.border),
                      const SizedBox(height: AppSpacing.xs),
                      _ShimmerBox(
                        controller: _shimmerController,
                        width: 50,
                        height: 12,
                        delay: 0.5,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _ShimmerBox(
                          controller: _shimmerController,
                          width: 60,
                          height: 24,
                          delay: 0.6,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        _ShimmerBox(
                          controller: _shimmerController,
                          width: 40,
                          height: 16,
                          delay: 0.7,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              // Footer
              Row(
                children: [
                  _ShimmerBox(
                    controller: _shimmerController,
                    width: 60,
                    height: 16,
                    delay: 0.8,
                  ),
                  const Spacer(),
                  _ShimmerBox(
                    controller: _shimmerController,
                    width: 80,
                    height: 28,
                    delay: 0.9,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  const _ShimmerBox({
    required this.controller,
    required this.width,
    required this.height,
    this.borderRadius = 4,
    this.delay = 0.0,
  });

  final AnimationController controller;
  final double width;
  final double height;
  final double borderRadius;
  final double delay;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final value = (controller.value + delay) % 1.0;
        final opacity = 0.3 + (0.7 * (0.5 - (value - 0.5).abs()) * 2);
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: AppColors.surfaceMuted.withValues(alpha: opacity),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        );
      },
    );
  }
}
