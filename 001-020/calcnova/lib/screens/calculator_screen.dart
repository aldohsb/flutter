import 'package:flutter/material.dart';
import '../logic/calculator_engine.dart';
import '../models/button_type.dart';
import '../models/calculator_operation.dart';
import '../theme/app_colors.dart';
import '../widgets/calculator_display.dart';
import '../widgets/calculator_keypad.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorEngine _engine = CalculatorEngine();

  void _handleKeyTap(String label, ButtonType type) {
    setState(() {
      switch (type) {
        case ButtonType.number:
          label == '.' ? _engine.inputDecimal() : _engine.inputDigit(label);
          break;
        case ButtonType.operatorBtn:
          _engine.chooseOperation(_operationFor(label));
          break;
        case ButtonType.equalsBtn:
          _engine.calculateResult();
          break;
        case ButtonType.function:
          _handleFunction(label);
          break;
      }
    });
  }

  void _handleFunction(String label) {
    switch (label) {
      case 'C':
        _engine.clear();
        break;
      case '⌫':
        _engine.backspace();
        break;
      case '%':
        _engine.percent();
        break;
      case '±':
        _engine.toggleSign();
        break;
    }
  }

  CalculatorOperation _operationFor(String symbol) {
    switch (symbol) {
      case '+':
        return CalculatorOperation.add;
      case '−':
        return CalculatorOperation.subtract;
      case '×':
        return CalculatorOperation.multiply;
      case '÷':
        return CalculatorOperation.divide;
      default:
        return CalculatorOperation.none;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.backgroundStart, AppColors.backgroundEnd],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              CalculatorDisplay(
                expression: _engine.expression,
                value: _engine.display,
              ),
              Expanded(child: CalculatorKeypad(onKeyTap: _handleKeyTap)),
            ],
          ),
        ),
      ),
    );
  }
}