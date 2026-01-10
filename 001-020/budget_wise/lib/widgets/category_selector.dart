import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/transaction.dart';
import '../providers/budget_provider.dart';
import '../utils/constants.dart';

class CategorySelector extends StatelessWidget {
  final TransactionType transactionType;
  final String? selectedCategoryId;
  final Function(String) onCategorySelected;
  
  const CategorySelector({
    super.key,
    required this.transactionType,
    required this.selectedCategoryId,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BudgetProvider>(context, listen: false);
    final categories = provider.categories
        .where((cat) => cat.isIncome == (transactionType == TransactionType.income))
        .toList();
    
    if (categories.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: const Center(
          child: Text(
            'Tidak ada kategori tersedia',
            style: AppTextStyles.subtitle2,
          ),
        ),
      );
    }
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: categories.map((category) {
          final isSelected = selectedCategoryId == category.id;
          
          return GestureDetector(
            onTap: () => onCategorySelected(category.id),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? Color(category.colorValue).withOpacity(0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected
                      ? Color(category.colorValue)
                      : AppColors.border,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    IconData(
                      category.iconCodePoint,
                      fontFamily: 'MaterialIcons',
                    ),
                    color: Color(category.colorValue),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    category.name,
                    style: AppTextStyles.body1.copyWith(
                      color: isSelected
                          ? Color(category.colorValue)
                          : AppColors.textPrimary,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}