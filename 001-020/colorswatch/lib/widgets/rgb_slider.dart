import 'package:flutter/material.dart';

class RgbSlider extends StatelessWidget {
  final String label;
  final double value;
  final Color trackColor;
  final ValueChanged<double> onChanged;

  const RgbSlider({
    super.key,
    required this.label,
    required this.value,
    required this.trackColor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 22,
          child: Text(
            label,
            style: TextStyle(
              color: trackColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderThemeData(
              activeTrackColor: trackColor,
              thumbColor: trackColor,
              overlayColor: trackColor.withValues(alpha: 0.2),
              inactiveTrackColor: trackColor.withValues(alpha: 0.15),
            ),
            child: Slider(
              value: value,
              min: 0,
              max: 255,
              onChanged: onChanged,
            ),
          ),
        ),
        SizedBox(
          width: 40,
          child: Text(
            value.round().toString(),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}