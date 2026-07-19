import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerDisplay extends StatelessWidget {
  final String time;
  final double fontSize;
  final Color? color;
  final bool isRunning;
  
  const TimerDisplay({
    super.key,
    required this.time,
    this.fontSize = 72.0,
    this.color,
    this.isRunning = false,
  });
  
  @override
  Widget build(BuildContext context) {
    final displayColor = color ?? Theme.of(context).textTheme.displayLarge!.color!;
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: GoogleFonts.inter(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              color: displayColor,
              letterSpacing: -2,
              height: 1.0,
              fontFeatures: const [
                FontFeature.tabularFigures(),
              ],
            ),
          ),
          if (isRunning)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: _buildPulsingIndicator(displayColor),
            ),
        ],
      ),
    );
  }
  
  Widget _buildPulsingIndicator(Color color) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.3, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.8),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.4),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        );
      },
      onEnd: () {
        // Repeat animation
      },
    );
  }
}
