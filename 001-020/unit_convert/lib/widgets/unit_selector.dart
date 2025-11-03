// Widget untuk memilih unit (meter, kilogram, dll)
// Menampilkan bottom sheet dengan list unit yang tersedia

import 'package:flutter/material.dart';
import '../models/unit_item.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class UnitSelector extends StatelessWidget {
  final UnitItem? selectedUnit; // Unit yang sedang dipilih
  final List<UnitItem> availableUnits; // List unit yang bisa dipilih
  final Function(UnitItem) onUnitSelected; // Callback ketika unit dipilih
  final String label; // Label "Dari" atau "Ke"

  const UnitSelector({
    super.key,
    required this.selectedUnit,
    required this.availableUnits,
    required this.onUnitSelected,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showUnitPicker(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.textLight,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Label
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: 8),
            
            // Selected unit name
            Text(
              selectedUnit?.name ?? 'Pilih Unit',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            
            // Dropdown icon
            const Icon(
              Icons.arrow_drop_down,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  // Method untuk show bottom sheet unit picker
  void _showUnitPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      // isScrollControlled agar bottom sheet bisa full height
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _UnitPickerSheet(
        units: availableUnits,
        selectedUnit: selectedUnit,
        onUnitSelected: (unit) {
          onUnitSelected(unit);
          Navigator.pop(context); // Close bottom sheet
        },
      ),
    );
  }
}

// Widget untuk bottom sheet unit picker
class _UnitPickerSheet extends StatelessWidget {
  final List<UnitItem> units;
  final UnitItem? selectedUnit;
  final Function(UnitItem) onUnitSelected;

  const _UnitPickerSheet({
    required this.units,
    required this.selectedUnit,
    required this.onUnitSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Height maksimal 70% dari screen height
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
          // Handle untuk drag down
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pilih Unit',
                  style: AppTextStyles.heading3,
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // List units
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: units.length,
              itemBuilder: (context, index) {
                final unit = units[index];
                final isSelected = unit == selectedUnit;

                return ListTile(
                  onTap: () => onUnitSelected(unit),
                  // Background color kalau selected
                  tileColor: isSelected 
                      ? AppColors.primary.withOpacity(0.1) 
                      : null,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  title: Text(
                    unit.name,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected ? AppColors.primary : AppColors.textPrimary,
                    ),
                  ),
                  subtitle: Text(
                    unit.symbol,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: isSelected ? AppColors.primary : AppColors.textSecondary,
                    ),
                  ),
                  trailing: isSelected
                      ? const Icon(
                          Icons.check_circle,
                          color: AppColors.primary,
                        )
                      : null,
                );
              },
            ),
          ),

          // Bottom padding untuk safe area
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}