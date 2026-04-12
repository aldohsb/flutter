import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final int total;
  final int current;

  const ProgressIndicatorWidget({
    super.key,
    required this.total,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    // For large sets, show a slim linear bar instead of dots
    if (total > 20) {
      return _LinearProgress(total: total, current: current);
    }
    return _DotProgress(total: total, current: current);
  }
}

class _DotProgress extends StatelessWidget {
  final int total;
  final int current;

  const _DotProgress({required this.total, required this.current});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 12,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: total,
        separatorBuilder: (_, __) => const SizedBox(width: 6),
        itemBuilder: (_, index) {
          final isActive = index == current;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            width: isActive ? 20 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive
                  ? Colors.white
                  : Colors.white.withAlpha(100),
              borderRadius: BorderRadius.circular(4),
            ),
          );
        },
      ),
    );
  }
}

class _LinearProgress extends StatelessWidget {
  final int total;
  final int current;

  const _LinearProgress({required this.total, required this.current});

  @override
  Widget build(BuildContext context) {
    final progress = total > 0 ? (current + 1) / total : 0.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '${current + 1} / $total',
          style: TextStyle(
            color: Colors.white.withAlpha(200),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white.withAlpha(60),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}
