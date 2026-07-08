import 'package:flutter/material.dart';
import '../models/button_type.dart';
import 'calculator_button.dart';

class CalculatorKeypad extends StatelessWidget {
  final void Function(String label, ButtonType type) onKeyTap;

  const CalculatorKeypad({super.key, required this.onKeyTap});

  static const List<List<Map<String, dynamic>>> _rows = [
    [
      {'label': 'C', 'type': ButtonType.function},
      {'label': '⌫', 'type': ButtonType.function},
      {'label': '%', 'type': ButtonType.function},
      {'label': '÷', 'type': ButtonType.operatorBtn},
    ],
    [
      {'label': '7', 'type': ButtonType.number},
      {'label': '8', 'type': ButtonType.number},
      {'label': '9', 'type': ButtonType.number},
      {'label': '×', 'type': ButtonType.operatorBtn},
    ],
    [
      {'label': '4', 'type': ButtonType.number},
      {'label': '5', 'type': ButtonType.number},
      {'label': '6', 'type': ButtonType.number},
      {'label': '−', 'type': ButtonType.operatorBtn},
    ],
    [
      {'label': '1', 'type': ButtonType.number},
      {'label': '2', 'type': ButtonType.number},
      {'label': '3', 'type': ButtonType.number},
      {'label': '+', 'type': ButtonType.operatorBtn},
    ],
    [
      {'label': '±', 'type': ButtonType.function},
      {'label': '0', 'type': ButtonType.number},
      {'label': '.', 'type': ButtonType.number},
      {'label': '=', 'type': ButtonType.equalsBtn},
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(children: _rows.map(_buildRow).toList()),
    );
  }

  Widget _buildRow(List<Map<String, dynamic>> row) {
    return Expanded(
      child: Row(
        children: row.map((data) {
          return Expanded(
            child: CalculatorButton(
              label: data['label'] as String,
              type: data['type'] as ButtonType,
              onPressed: () => onKeyTap(
                data['label'] as String,
                data['type'] as ButtonType,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}