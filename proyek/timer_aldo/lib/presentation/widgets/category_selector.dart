import 'package:flutter/material.dart';
import '../../data/models/category.dart';

class CategorySelector extends StatelessWidget {
  final List<Category> categories;
  final Category? selectedCategory;
  final Function(Category) onCategorySelected;
  
  const CategorySelector({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: categories.map((category) {
          final isSelected = selectedCategory?.id == category.id;
          
          return _buildCategoryChip(
            context,
            category,
            isSelected,
          );
        }).toList(),
      ),
    );
  }
  
  Widget _buildCategoryChip(
    BuildContext context,
    Category category,
    bool isSelected,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onCategorySelected(category),
        borderRadius: BorderRadius.circular(24),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? category.color.withValues(alpha: 0.2)
                : Colors.transparent,
            border: Border.all(
              color: isSelected ? category.color : Colors.grey.withValues(alpha: 0.3),
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                category.icon,
                size: 18,
                color: isSelected ? category.color : Colors.grey,
              ),
              const SizedBox(width: 8),
              Text(
                category.name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? category.color
                      : Theme.of(context).textTheme.bodyMedium!.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
