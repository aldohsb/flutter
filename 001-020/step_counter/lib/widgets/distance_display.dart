import 'package:flutter/material.dart';
import 'neumorphic_card.dart';
import '../config/theme_config.dart';
import '../utils/calculations.dart';

class DistanceDisplay extends StatelessWidget {
  final double distance;
  
  const DistanceDisplay({
    super.key,
    required this.distance,
  });
  
  @override
  Widget build(BuildContext context) {
    return NeumorphicCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: ThemeConfig.secondaryGradient,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.directions_walk,
              color: Colors.white,
              size: 28,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Distance value
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: distance),
            duration: const Duration(milliseconds: 500),
            builder: (context, value, child) {
              return Text(
                StepCalculations.formatDistance(value),
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: ThemeConfig.secondaryColor,
                    ),
              );
            },
          ),
          
          const SizedBox(height: 4),
          
          // Label
          Text(
            'KILOMETERS',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ThemeConfig.textSecondary,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}