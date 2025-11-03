// Screen utama untuk converter
// Menampilkan category tabs, conversion display, unit selector, dan number pad

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/converter_provider.dart';
import '../widgets/category_tabs.dart';
import '../widgets/conversion_display.dart';
import '../widgets/unit_selector.dart';
import '../widgets/number_pad.dart';
import '../utils/unit_definitions.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      // AppBar
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: const Text(
          'Unit Converter',
          style: AppTextStyles.heading2,
        ),
        actions: [
          // Button untuk show history
          IconButton(
            onPressed: () => _showHistory(context),
            icon: const Icon(
              Icons.history,
              color: AppColors.primary,
            ),
            tooltip: 'Riwayat',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Consumer<ConverterProvider>(
        builder: (context, provider, child) {
          // Show loading indicator saat initialization
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: [
              // Category tabs - horizontal scrollable
              CategoryTabs(
                categories: UnitDefinitions.categories,
              ),

              const Divider(height: 1),

              // Main content - scrollable
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 16),

                      // Unit selectors
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            // From unit selector
                            Expanded(
                              child: UnitSelector(
                                label: 'Dari',
                                selectedUnit: provider.fromUnit,
                                availableUnits: provider.availableUnits,
                                onUnitSelected: (unit) {
                                  provider.selectFromUnit(unit);
                                },
                              ),
                            ),
                            const SizedBox(width: 16),

                            // To unit selector
                            Expanded(
                              child: UnitSelector(
                                label: 'Ke',
                                selectedUnit: provider.toUnit,
                                availableUnits: provider.availableUnits,
                                onUnitSelected: (unit) {
                                  provider.selectToUnit(unit);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Conversion display
                      const ConversionDisplay(),
                    ],
                  ),
                ),
              ),

              const Divider(height: 1),

              // Number pad
              const NumberPad(),

              // Bottom safe area
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          );
        },
      ),
    );
  }

  // Method untuk show history bottom sheet
  void _showHistory(BuildContext context) {
    final provider = Provider.of<ConverterProvider>(context, listen: false);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _HistorySheet(provider: provider),
    );
  }
}

// Widget untuk history bottom sheet
class _HistorySheet extends StatelessWidget {
  final ConverterProvider provider;

  const _HistorySheet({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Riwayat Konversi',
                  style: AppTextStyles.heading3,
                ),
                Row(
                  children: [
                    // Clear all button
                    if (provider.history.isNotEmpty)
                      TextButton(
                        onPressed: () {
                          provider.clearHistory();
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Hapus Semua',
                          style: AppTextStyles.buttonSmall.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                      ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // History list
          Flexible(
            child: provider.history.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.history_outlined,
                            size: 64,
                            color: AppColors.textLight,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Belum ada riwayat',
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    itemCount: provider.history.length,
                    separatorBuilder: (context, index) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final result = provider.history[index];
                      return ListTile(
                        onTap: () {
                          provider.loadFromHistory(result);
                          Navigator.pop(context);
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        title: Text(
                          result.displayText,
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          result.formattedDate,
                          style: AppTextStyles.caption,
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: AppColors.textLight,
                        ),
                      );
                    },
                  ),
          ),

          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}