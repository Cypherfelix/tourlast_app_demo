import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';

class SearchButton extends StatefulWidget {
  const SearchButton({
    super.key,
    required this.textTheme,
    this.onPressed,
    this.isLoading = false,
  });

  final TextTheme? textTheme;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _handleTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.lg,
      ),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: GestureDetector(
          onTapDown: widget.isLoading ? null : _handleTapDown,
          onTapUp: widget.isLoading ? null : _handleTapUp,
          onTapCancel: widget.isLoading ? null : _handleTapCancel,
          onTap: widget.isLoading || widget.onPressed == null
              ? null
              : widget.onPressed,
          child: SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: widget.isLoading || widget.onPressed == null
                  ? null
                  : () {
                      // Animation handled by GestureDetector
                      widget.onPressed?.call();
                    },
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: widget.isLoading
                    ? AppColors.primaryBlue.withValues(alpha: 0.7)
                    : AppColors.primaryBlue,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.isLoading) ...[
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Text(
                      'Searching...',
                      style: widget.textTheme?.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ] else ...[
                    const Icon(Icons.search_rounded, size: 24),
                    const SizedBox(width: AppSpacing.md),
                    Text(
                      'Search Flights',
                      style: widget.textTheme?.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
