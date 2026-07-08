import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/color_utils.dart';

class ColorPreview extends StatelessWidget {
  final Color color;

  const ColorPreview({super.key, required this.color});

  void _copyHex(BuildContext context) {
    final hex = colorToHex(color);
    Clipboard.setData(ClipboardData(text: hex));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$hex disalin')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textColor = contrastColor(color);
    return GestureDetector(
      onTap: () => _copyHex(context),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 180,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.5),
              blurRadius: 30,
              spreadRadius: 2,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          colorToHex(color),
          style: TextStyle(
            color: textColor,
            fontSize: 26,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}