import 'package:flutter/material.dart';

class SocialIconWidget extends StatelessWidget {
  final IconData icon;
  final String platform;
  final Color color;
  final VoidCallback? onTap;

  const SocialIconWidget({
    super.key,
    required this.icon,
    required this.platform,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: platform,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withValues(alpha: 0.12),
            border: Border.all(
              color: color.withValues(alpha: 0.35),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.2),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Icon(icon, size: 22, color: color),
        ),
      ),
    );
  }
}