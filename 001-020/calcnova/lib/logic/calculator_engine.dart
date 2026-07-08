import 'package:flutter/foundation.dart';
import '../models/calculator_operation.dart';

class CalculatorEngine {
  String _display = '0';
  String _expression = '';
  double _previousValue = 0;
  CalculatorOperation _operation = CalculatorOperation.none;
  bool _shouldReset = false;

  String get display => _display;
  String get expression => _expression;

  void inputDigit(String digit) {
    if (_display == '0' || _shouldReset) {
      _display = digit;
      _shouldReset = false;
    } else {
      _display += digit;
    }
  }

  void inputDecimal() {
    if (_shouldReset) {
      _display = '0.';
      _shouldReset = false;
      return;
    }
    if (!_display.contains('.')) _display += '.';
  }

  void chooseOperation(CalculatorOperation op) {
    if (_operation != CalculatorOperation.none && !_shouldReset) {
      _calculate();
    }
    _previousValue = double.parse(_display);
    _operation = op;
    _expression = '${_formatNumber(_previousValue)} ${_symbolFor(op)}';
    _shouldReset = true;
  }

  void calculateResult() {
    if (_operation == CalculatorOperation.none) return;
    _calculate();
    _expression = '';
    _operation = CalculatorOperation.none;
    _shouldReset = true;
  }

  void _calculate() {
    final current = double.parse(_display);
    double result;
    switch (_operation) {
      case CalculatorOperation.add:
        result = _previousValue + current;
        break;
      case CalculatorOperation.subtract:
        result = _previousValue - current;
        break;
      case CalculatorOperation.multiply:
        result = _previousValue * current;
        break;
      case CalculatorOperation.divide:
        result = current == 0 ? double.nan : _previousValue / current;
        break;
      case CalculatorOperation.none:
        result = current;
        break;
    }
    _display = _formatNumber(result);
    _previousValue = result;
  }

  void clear() {
    _display = '0';
    _expression = '';
    _previousValue = 0;
    _operation = CalculatorOperation.none;
    _shouldReset = false;
  }

  void backspace() {
    final onlyMinus = _display.length == 2 && _display.startsWith('-');
    if (_display.length <= 1 || onlyMinus) {
      _display = '0';
    } else {
      _display = _display.substring(0, _display.length - 1);
    }
  }

  void toggleSign() {
    if (_display == '0') return;
    _display = _display.startsWith('-') ? _display.substring(1) : '-$_display';
  }

  void percent() {
    final value = double.parse(_display) / 100;
    _display = _formatNumber(value);
  }

  @visibleForTesting
  String formatForTest(double value) => _formatNumber(value);

  String _formatNumber(double value) {
    if (value.isNaN) return 'Error';
    if (value == value.roundToDouble() && value.abs() < 1e15) {
      return value.toInt().toString();
    }
    return value.toString();
  }

  String _symbolFor(CalculatorOperation op) {
    switch (op) {
      case CalculatorOperation.add:
        return '+';
      case CalculatorOperation.subtract:
        return '−';
      case CalculatorOperation.multiply:
        return '×';
      case CalculatorOperation.divide:
        return '÷';
      case CalculatorOperation.none:
        return '';
    }
  }
}