// Widget untuk menampilkan input dan output conversion
// Termasuk unit selector dan arrow conversion

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/converter_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../utils/conversion_calculator.dart';

class ConversionDisplay extends StatelessWidget {
  const ConversionDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ConverterProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Input value display
              _buildValueDisplay(
                context: context,
                label: 'Dari',
                value: provider.inputValue,
                unit: provider.fromUnit?.symbol ?? '-',
                isInput: true,
              ),

              const SizedBox(height: 24),

              // Swap button
              _buildSwapButton(context),

              const SizedBox(height: 24),

              // Output value display
              _buildValueDisplay(
                context: context,
                label: 'Ke',
                value: provider.outputValue != null
                    ? ConversionCalculator.formatResult(provider.outputValue!)
                    : '0',
                unit: provider.toUnit?.symbol ?? '-',
                isInput: false,
              ),

              const SizedBox(height: 24),

              // Save to history button
              if (provider.outputValue != null)
                _buildSaveButton(context, provider),
            ],
          ),
        );
      },
    );
  }

  // Widget untuk display value (input atau output)
  Widget _buildValueDisplay({
    required BuildContext context,
    required String label,
    required String value,
    required String unit,
    required bool isInput,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isInput 
            ? AppColors.primary.withOpacity(0.05)
            : AppColors.accent.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isInput
              ? AppColors.primary.withOpacity(0.2)
              : AppColors.accent.withOpacity(0.2),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: isInput ? AppColors.primary : AppColors.accent,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          
          // Value dan Unit
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Value - flex agar mengambil space sebanyak mungkin
              Expanded(
                child: Text(
                  value,
                  style: AppTextStyles.displayMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),
              
              // Unit
              Text(
                unit,
                style: AppTextStyles.heading3.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget untuk swap button
  Widget _buildSwapButton(BuildContext context) {
    return Center(
      child: Material(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(50),
        // Elevation untuk shadow
        elevation: 4,
        child: InkWell(
          // InkWell untuk ripple effect
          onTap: () {
            final provider = Provider.of<ConverterProvider>(context, listen: false);
            provider.swapUnits();
          },
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: 56,
            height: 56,
            child: const Icon(
              Icons.swap_vert_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }

  // Widget untuk save button
  Widget _buildSaveButton(BuildContext context, ConverterProvider provider) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          provider.saveToHistory();
          
          // Show snackbar sebagai feedback
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tersimpan ke riwayat'),
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.success,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
        ),
        icon: const Icon(Icons.bookmark_add_outlined),
        label: const Text(
          'Simpan ke Riwayat',
          style: AppTextStyles.button,
        ),
      ),
    );
  }
}