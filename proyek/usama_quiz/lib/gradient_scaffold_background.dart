import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Bungkus konten layar dengan latar bergradasi lembut khas taman zen,
/// dihiasi lingkaran-lingkaran samar seperti riak pasir yang disapu.
class GradientScaffoldBackground extends StatelessWidget {
  const GradientScaffoldBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.sandBackground,
                AppColors.sagePale,
              ],
            ),
          ),
        ),
        Positioned(
          top: -80,
          right: -60,
          child: _RippleCircle(size: 220, color: AppColors.sageLight.withValues(alpha: 0.35)),
        ),
        Positioned(
          bottom: -100,
          left: -70,
          child: _RippleCircle(size: 260, color: AppColors.stone.withValues(alpha: 0.4)),
        ),
        child,
      ],
    );
  }
}

class _RippleCircle extends StatelessWidget {
  const _RippleCircle({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 18),
      ),
    );
  }
}
