import 'package:flutter/material.dart';
import '../models/button_type.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CalculatorButton extends StatefulWidget {
  final String label;
  final ButtonType type;
  final VoidCallback onPressed;

  const CalculatorButton({
    super.key,
    required this.label,
    required this.type,
    required this.onPressed,
  });

  @override
  State<CalculatorButton> createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton> {
  bool _isPressed = false;

  void _setPressed(bool value) => setState(() => _isPressed = value);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) {
        _setPressed(false);
        widget.onPressed();
      },
      onTapCancel: () => _setPressed(false),
      child: Container(
        margin: const EdgeInsets.all(6),
        alignment: Alignment.center,
        decoration: _buildDecoration(),
        child: Text(widget.label, style: _textStyle()),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      color: _isPressed ? _pressedColor() : _baseColor(),
      borderRadius: BorderRadius.circular(24),
      boxShadow: _isPressed
          ? const []
          : [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.35),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
              BoxShadow(
                color: AppColors.glowNova.withValues(alpha: 0.06),
                blurRadius: 14,
                offset: const Offset(0, -2),
              ),
            ],
    );
  }

  Color _baseColor() {
    switch (widget.type) {
      case ButtonType.number:
        return AppColors.surfaceDark;
      case ButtonType.function:
        return AppColors.surfaceMuted;
      case ButtonType.operatorBtn:
        return AppColors.accentOperator;
      case ButtonType.equalsBtn:
        return AppColors.accentEquals;
    }
  }

  Color _pressedColor() {
    switch (widget.type) {
      case ButtonType.number:
        return AppColors.surfaceDarkPressed;
      case ButtonType.function:
        return AppColors.surfaceMutedPressed;
      case ButtonType.operatorBtn:
        return AppColors.accentOperatorPressed;
      case ButtonType.equalsBtn:
        return AppColors.accentEqualsPressed;
    }
  }

  TextStyle _textStyle() {
    switch (widget.type) {
      case ButtonType.number:
        return AppTextStyles.buttonNumber;
      case ButtonType.function:
        return AppTextStyles.buttonFunction;
      case ButtonType.operatorBtn:
      case ButtonType.equalsBtn:
        return AppTextStyles.buttonOperator;
    }
  }
}