import 'package:flutter/material.dart';
import '../config/theme_config.dart';
import '../utils/constants.dart';

class NeumorphicCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final bool isPressed;
  final VoidCallback? onTap;
  
  const NeumorphicCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.isPressed = false,
    this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: width,
        height: height,
        padding: padding ?? const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: ThemeConfig.surfaceColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isPressed
              ? [
                  // Pressed state - inverted shadows
                  BoxShadow(
                    color: ThemeConfig.shadowDark.withOpacity(0.5),
                    offset: const Offset(-5, -5),
                    blurRadius: 10,
                  ),
                  BoxShadow(
                    color: ThemeConfig.shadowLight.withOpacity(0.8),
                    offset: const Offset(5, 5),
                    blurRadius: 10,
                  ),
                ]
              : [
                  // Normal state - raised effect
                  BoxShadow(
                    color: ThemeConfig.shadowLight,
                    offset: const Offset(-AppConstants.neumorphicDistance, -AppConstants.neumorphicDistance),
                    blurRadius: AppConstants.neumorphicBlur,
                  ),
                  BoxShadow(
                    color: ThemeConfig.shadowDark.withOpacity(0.5),
                    offset: const Offset(AppConstants.neumorphicDistance, AppConstants.neumorphicDistance),
                    blurRadius: AppConstants.neumorphicBlur,
                  ),
                ],
        ),
        child: child,
      ),
    );
  }
}