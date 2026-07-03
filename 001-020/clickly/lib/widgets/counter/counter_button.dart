import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';

class CounterButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String heroTag;
  final Color? backgroundColor;

  const CounterButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.heroTag,
    this.backgroundColor,
  });

  @override
  State<CounterButton> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
  bool _isPressed = false;

  void _setPressed(bool pressed) {
    setState(() => _isPressed = pressed);
  }

  void _handleTap() {
    HapticFeedback.lightImpact();
    // getar halus saat ditekan — otomatis diabaikan Flutter di web/Windows
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      // 3 event ini menangkap siklus jari: tekan, lepas, atau dibatalkan
      child: AnimatedScale(
        scale: _isPressed ? 0.9 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowDark,
                offset: const Offset(4, 4),
                blurRadius: 8,
              ),
              BoxShadow(
                color: AppColors.shadowLight,
                offset: const Offset(-4, -4),
                blurRadius: 8,
              ),
            ],
          ),
          child: FloatingActionButton(
            heroTag: widget.heroTag,
            elevation: 0,
            backgroundColor: widget.backgroundColor ?? AppColors.surface,
            onPressed: _handleTap,
            child: Icon(widget.icon, color: AppColors.primaryText),
          ),
        ),
      ),
    );
  }
}