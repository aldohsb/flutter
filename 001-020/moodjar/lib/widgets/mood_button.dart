import 'package:flutter/material.dart';
import '../models/mood.dart';

class MoodButton extends StatelessWidget {
  final Mood mood;
  final bool isSelected;
  final VoidCallback onTap;

  const MoodButton({
    super.key,
    required this.mood,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          color: isSelected ? mood.color : mood.color.withOpacity(0.25),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            mood.label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? Colors.white : mood.color,
            ),
          ),
        ),
      ),
    );
  }
}