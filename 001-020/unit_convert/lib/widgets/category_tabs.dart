// Widget untuk menampilkan tabs kategori converter
// User bisa pilih kategori: Length, Weight, Temperature, dll

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/unit_category.dart';
import '../providers/converter_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class CategoryTabs extends StatelessWidget {
  // List kategori yang akan ditampilkan
  final List<UnitCategory> categories;

  const CategoryTabs({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    // Consumer adalah widget yang listen ke perubahan dari Provider
    // Ketika Provider berubah, Consumer akan rebuild
    return Consumer<ConverterProvider>(
      builder: (context, provider, child) {
        return Container(
          height: 80, // Tinggi container tabs
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListView.builder(
            // Scroll horizontal
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            // itemCount adalah jumlah item yang akan di-build
            itemCount: categories.length,
            // itemBuilder adalah function yang build setiap item
            itemBuilder: (context, index) {
              final category = categories[index];
              // Cek apakah kategori ini sedang dipilih
              final isSelected = provider.selectedCategory == category;

              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _CategoryTabItem(
                  category: category,
                  isSelected: isSelected,
                  onTap: () {
                    // Ketika di-tap, ganti kategori di provider
                    provider.selectCategory(category);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// Widget untuk single tab item
// Private class (dimulai dengan _) artinya hanya bisa diakses dari file ini
class _CategoryTabItem extends StatelessWidget {
  final UnitCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryTabItem({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        // AnimatedContainer automatically animate ketika properties berubah
        duration: const Duration(milliseconds: 200),
        width: 100,
        decoration: BoxDecoration(
          // Kalau selected, kasih warna background
          color: isSelected ? category.color.withOpacity(0.15) : Colors.transparent,
          // Border kalau selected
          border: Border.all(
            color: isSelected ? category.color : AppColors.textLight,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Icon(
              category.icon,
              color: isSelected ? category.color : AppColors.textSecondary,
              size: 28,
            ),
            const SizedBox(height: 4),
            // Label
            Text(
              category.displayName,
              style: AppTextStyles.caption.copyWith(
                color: isSelected ? category.color : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis, // Kalau kepanjangan, kasih ...
            ),
          ],
        ),
      ),
    );
  }
}