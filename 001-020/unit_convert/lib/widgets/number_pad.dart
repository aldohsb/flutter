// Widget number pad seperti di calculator
// Tombol angka 0-9, decimal point, backspace, clear

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/converter_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class NumberPad extends StatelessWidget {
  const NumberPad({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ConverterProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Row 1: 7, 8, 9
              _buildNumberRow(context, ['7', '8', '9']),
              const SizedBox(height: 12),
              
              // Row 2: 4, 5, 6
              _buildNumberRow(context, ['4', '5', '6']),
              const SizedBox(height: 12),
              
              // Row 3: 1, 2, 3
              _buildNumberRow(context, ['1', '2', '3']),
              const SizedBox(height: 12),
              
              // Row 4: 0, ., C, ←
              Row(
                children: [
                  // Tombol 0
                  Expanded(
                    child: _NumberButton(
                      label: '0',
                      onTap: () => provider.handleNumberInput('0'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Tombol decimal point
                  Expanded(
                    child: _NumberButton(
                      label: '.',
                      onTap: () => provider.handleDecimalPoint(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Tombol Clear
                  Expanded(
                    child: _NumberButton(
                      label: 'C',
                      backgroundColor: AppColors.error.withOpacity(0.1),
                      textColor: AppColors.error,
                      onTap: () => provider.handleClear(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Tombol Backspace
                  Expanded(
                    child: _NumberButton(
                      icon: Icons.backspace_outlined,
                      backgroundColor: AppColors.operatorButton,
                      onTap: () => provider.handleBackspace(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Helper method untuk build row dengan 3 tombol
  Widget _buildNumberRow(BuildContext context, List<String> numbers) {
    final provider = Provider.of<ConverterProvider>(context, listen: false);
    
    return Row(
      children: numbers.map((number) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              // Kasih spacing antar tombol
              right: number == numbers.last ? 0 : 12,
            ),
            child: _NumberButton(
              label: number,
              onTap: () => provider.handleNumberInput(number),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// Widget untuk single button di number pad
class _NumberButton extends StatefulWidget {
  final String? label; // Text yang ditampilkan
  final IconData? icon; // Atau icon (untuk backspace)
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback onTap;

  const _NumberButton({
    this.label,
    this.icon,
    this.backgroundColor,
    this.textColor,
    required this.onTap,
  });

  @override
  State<_NumberButton> createState() => _NumberButtonState();
}

class _NumberButtonState extends State<_NumberButton> {
  // State untuk handle press animation
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTapDown dipanggil ketika user mulai tap
      onTapDown: (_) {
        setState(() => _isPressed = true);
      },
      // onTapUp dipanggil ketika user release tap
      onTapUp: (_) {
        setState(() => _isPressed = false);
      },
      // onTapCancel dipanggil kalau tap dibatalkan (drag keluar)
      onTapCancel: () {
        setState(() => _isPressed = false);
      },
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: 64,
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? AppColors.numberButton,
          borderRadius: BorderRadius.circular(16),
          // Shadow untuk efek kedalaman
          boxShadow: _isPressed
              ? [] // Hilangkan shadow ketika pressed
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        // Transform untuk scale down ketika pressed
        transform: Matrix4.identity()
          ..scale(_isPressed ? 0.95 : 1.0),
        child: Center(
          child: widget.icon != null
              ? Icon(
                  widget.icon,
                  color: widget.textColor ?? AppColors.textPrimary,
                  size: 24,
                )
              : Text(
                  widget.label!,
                  style: AppTextStyles.numberPad.copyWith(
                    color: widget.textColor ?? AppColors.textPrimary,
                  ),
                ),
        ),
      ),
    );
  }
}