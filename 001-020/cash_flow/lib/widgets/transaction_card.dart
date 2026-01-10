import 'package:flutter/material.dart';
import '../database/app_database.dart';
import '../utils/app_theme.dart';
import '../utils/helpers.dart';
import '../utils/constants.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const TransactionCard({
    super.key,
    required this.transaction,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == AppConstants.typeIncome;
    final categoryIcon = _getCategoryIcon(transaction.category);
    final categoryColor = _getCategoryColor(transaction.category, isIncome);

    return Dismissible(
      key: Key(transaction.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => onDelete?.call(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppTheme.expenseColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
          size: 28,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Category Icon
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: categoryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      categoryIcon,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Description and Category
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.description,
                        style: AppTheme.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        transaction.category,
                        style: AppTheme.bodyMedium.copyWith(
                          color: categoryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        Helpers.formatDate(transaction.date),
                        style: AppTheme.bodyMedium.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 12),
                
                // Amount
                Text(
                  '${isIncome ? '+' : '-'} ${Helpers.formatCurrency(transaction.amount)}',
                  style: AppTheme.bodyLarge.copyWith(
                    color: isIncome ? AppTheme.incomeColor : AppTheme.expenseColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getCategoryIcon(String category) {
    final allCategories = [
      ...AppConstants.incomeCategories,
      ...AppConstants.expenseCategories,
    ];
    
    for (var cat in allCategories) {
      if (cat['name'] == category) {
        return cat['icon'] as String;
      }
    }
    
    return '📦';
  }

  Color _getCategoryColor(String category, bool isIncome) {
    final categories = isIncome 
        ? AppConstants.incomeCategories 
        : AppConstants.expenseCategories;
    
    for (var cat in categories) {
      if (cat['name'] == category) {
        return Color(cat['color'] as int);
      }
    }
    
    return AppTheme.textSecondary;
  }
}