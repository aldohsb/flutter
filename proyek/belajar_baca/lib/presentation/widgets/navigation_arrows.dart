import 'package:flutter/material.dart';

class NavigationArrows extends StatelessWidget {
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final bool hasPrevious;
  final bool hasNext;

  const NavigationArrows({
    super.key,
    this.onPrevious,
    this.onNext,
    required this.hasPrevious,
    required this.hasNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ArrowButton(
            icon: Icons.chevron_left_rounded,
            onTap: hasPrevious ? onPrevious : null,
            visible: hasPrevious,
          ),
          _ArrowButton(
            icon: Icons.chevron_right_rounded,
            onTap: hasNext ? onNext : null,
            visible: hasNext,
          ),
        ],
      ),
    );
  }
}

class _ArrowButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool visible;

  const _ArrowButton({
    required this.icon,
    this.onTap,
    required this.visible,
  });

  @override
  State<_ArrowButton> createState() => _ArrowButtonState();
}

class _ArrowButtonState extends State<_ArrowButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.85,
      upperBound: 1.0,
      value: 1.0,
    );
    _scaleAnim = _controller;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(_) {
    if (widget.visible) _controller.reverse();
  }

  void _onTapUp(_) {
    if (widget.visible) _controller.forward();
  }

  void _onTapCancel() {
    if (widget.visible) _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.visible) {
      return const SizedBox(width: 56, height: 56);
    }

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(51),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withAlpha(128),
              width: 2,
            ),
          ),
          child: Icon(
            widget.icon,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
    );
  }
}
