import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';

class AnswerOption extends StatefulWidget {
  final String text;
  final bool isSelected;
  final bool isCorrect;
  final bool isWrong;
  final VoidCallback? onTap;

  const AnswerOption({
    super.key,
    required this.text,
    required this.isSelected,
    required this.isCorrect,
    required this.isWrong,
    required this.onTap,
  });

  @override
  State<AnswerOption> createState() => _AnswerOptionState();
}

class _AnswerOptionState extends State<AnswerOption>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(AnswerOption oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected && !oldWidget.isSelected) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getBackgroundColor() {
    if (widget.isCorrect) {
      return AppColors.success.withOpacity(0.1);
    } else if (widget.isWrong) {
      return AppColors.error.withOpacity(0.1);
    } else if (widget.isSelected) {
      return AppColors.primaryLight;
    }
    return AppColors.greyLight;
  }

  Color _getBorderColor() {
    if (widget.isCorrect) {
      return AppColors.success;
    } else if (widget.isWrong) {
      return AppColors.error;
    } else if (widget.isSelected) {
      return AppColors.primaryMain;
    }
    return Colors.transparent;
  }

  IconData _getIconData() {
    if (widget.isCorrect) {
      return Icons.check_circle;
    } else if (widget.isWrong) {
      return Icons.cancel;
    }
    return Icons.radio_button_unchecked;
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Material(
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: _getBackgroundColor(),
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(
                color: _getBorderColor(),
                width: widget.isSelected || widget.isCorrect || widget.isWrong
                    ? 2
                    : 1,
              ),
            ),
            child: Row(
              children: [
                // Icon
                Icon(
                  _getIconData(),
                  color: widget.isCorrect
                      ? AppColors.success
                      : widget.isWrong
                          ? AppColors.error
                          : AppColors.primaryMain,
                  size: 28,
                ),
                const SizedBox(width: AppSpacing.lg),

                // Text - EXPANDED untuk full width
                Expanded(
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      fontSize: AppFontSizes.xl,
                      fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: AppColors.textDark,
                      fontFamily: _isFontNotoSansJP(widget.text)
                          ? 'Noto Sans JP'
                          : 'Roboto',
                    ),
                  ),
                ),

                // Feedback icon
                if (widget.isCorrect || widget.isWrong)
                  Padding(
                    padding: const EdgeInsets.only(left: AppSpacing.lg),
                    child: AnimatedCheckmark(
                      isCorrect: widget.isCorrect,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isFontNotoSansJP(String text) {
    // Check if text contains Japanese characters
    RegExp japaneseRegex =
        RegExp(r'[\u3040-\u309F\u30A0-\u30FF\u4E00-\u9FFF]');
    return japaneseRegex.hasMatch(text);
  }
}

class AnimatedCheckmark extends StatefulWidget {
  final bool isCorrect;

  const AnimatedCheckmark({super.key, required this.isCorrect});

  @override
  State<AnimatedCheckmark> createState() => _AnimatedCheckmarkState();
}

class _AnimatedCheckmarkState extends State<AnimatedCheckmark>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
      ),
      child: Icon(
        widget.isCorrect ? Icons.check_circle : Icons.cancel,
        color: widget.isCorrect ? AppColors.success : AppColors.error,
        size: 24,
      ),
    );
  }
}