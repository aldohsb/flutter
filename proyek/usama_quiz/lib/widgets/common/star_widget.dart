import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';

class StarWidget extends StatelessWidget {
  final int starCount; // 0-3
  final double size;
  final bool animated;

  const StarWidget({
    super.key,
    required this.starCount,
    this.size = 24,
    this.animated = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        final isFilled = index < starCount;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Icon(
            isFilled ? Icons.star : Icons.star_outline,
            color: isFilled ? AppColors.accentGold : AppColors.greyMid,
            size: size,
          ),
        );
      }),
    );
  }
}

class AnimatedStarWidget extends StatefulWidget {
  final int starCount;
  final double size;

  const AnimatedStarWidget({
    super.key,
    required this.starCount,
    this.size = 32,
  });

  @override
  State<AnimatedStarWidget> createState() => _AnimatedStarWidgetState();
}

class _AnimatedStarWidgetState extends State<AnimatedStarWidget>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      3,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      ),
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      for (int i = 0; i < widget.starCount; i++) {
        _controllers[i].forward();
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        final isFilled = index < widget.starCount;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(parent: _controllers[index], curve: Curves.bounceOut),
            ),
            child: Icon(
              isFilled ? Icons.star : Icons.star_outline,
              color: isFilled ? AppColors.accentGold : AppColors.greyMid,
              size: widget.size,
            ),
          ),
        );
      }),
    );
  }
}