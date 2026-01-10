import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/budget_provider.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';
import '../widgets/chart_widget.dart';
import '../services/pdf_service.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Statistik'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Consumer<BudgetProvider>(
            builder: (context, provider, _) {
              return IconButton(
                icon: const Icon(Icons.picture_as_pdf),
                onPressed: () => _exportToPdf(context, provider),
              );
            },
          ),
        ],
      ),
      body: Consumer<BudgetProvider>(
        builder: (context, provider, _) {
          final transactions = provider.getTransactionsForMonth(provider.selectedMonth);
          final totalIncome = provider.getTotalIncome(provider.selectedMonth);
          final totalExpense = provider.getTotalExpense(provider.selectedMonth);
          final expensesByCategory = provider.getExpensesByCategory(provider.selectedMonth);
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMonthSelector(context, provider),
                const SizedBox(height: 24),
                _buildSummaryCards(totalIncome, totalExpense),
                const SizedBox(height: 24),
                if (expensesByCategory.isNotEmpty) ...[
                  const Text(
                    'Pengeluaran Per Kategori',
                    style: AppTextStyles.headline2,
                  ),
                  const SizedBox(height: 16),
                  ChartWidget(
                    expensesByCategory: expensesByCategory,
                  ),
                  const SizedBox(height: 24),
                  _buildCategoryList(expensesByCategory, totalExpense),
                ] else
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        children: [
                          Icon(
                            Icons.pie_chart_outline,
                            size: 80,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Belum ada data pengeluaran',
                            style: AppTextStyles.subtitle1.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildMonthSelector(BuildContext context, BudgetProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              final newMonth = DateTime(
                provider.selectedMonth.year,
                provider.selectedMonth.month - 1,
              );
              provider.setSelectedMonth(newMonth);
            },
            icon: const Icon(Icons.chevron_left),
          ),
          Text(
            Helpers.formatMonth(provider.selectedMonth),
            style: AppTextStyles.subtitle1,
          ),
          IconButton(
            onPressed: () {
              final newMonth = DateTime(
                provider.selectedMonth.year,
                provider.selectedMonth.month + 1,
              );
              provider.setSelectedMonth(newMonth);
            },
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSummaryCards(double income, double expense) {
    final balance = income - expense;
    
    return Column(
      children: [
        _buildSummaryCard(
          'Total Pemasukan',
          income,
          Icons.arrow_downward,
          AppColors.income,
        ),
        const SizedBox(height: 12),
        _buildSummaryCard(
          'Total Pengeluaran',
          expense,
          Icons.arrow_upward,
          AppColors.expense,
        ),
        const SizedBox(height: 12),
        _buildSummaryCard(
          'Saldo',
          balance,
          Icons.account_balance_wallet,
          AppColors.primary,
        ),
      ],
    );
  }
  
  Widget _buildSummaryCard(
    String label,
    double amount,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.subtitle2,
                ),
                const SizedBox(height: 4),
                Text(
                  Helpers.formatCurrency(amount),
                  style: AppTextStyles.headline2.copyWith(color: color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCategoryList(Map<String, double> categories, double totalExpense) {
    final sortedCategories = categories.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Detail Per Kategori',
          style: AppTextStyles.headline2,
        ),
        const SizedBox(height: 12),
        ...sortedCategories.map((entry) {
          final percentage = (entry.value / totalExpense * 100);
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.key,
                      style: AppTextStyles.subtitle1,
                    ),
                    Text(
                      Helpers.formatCurrency(entry.value),
                      style: AppTextStyles.subtitle1.copyWith(
                        color: AppColors.expense,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: percentage / 100,
                          backgroundColor: AppColors.border,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.expense,
                          ),
                          minHeight: 6,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${percentage.toStringAsFixed(1)}%',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
  
  Future<void> _exportToPdf(BuildContext context, BudgetProvider provider) async {
    try {
      final transactions = provider.getTransactionsForMonth(provider.selectedMonth);
      final totalIncome = provider.getTotalIncome(provider.selectedMonth);
      final totalExpense = provider.getTotalExpense(provider.selectedMonth);
      final balance = provider.getBalance(provider.selectedMonth);
      final expensesByCategory = provider.getExpensesByCategory(provider.selectedMonth);
      
      await PdfService.generateMonthlyReport(
        month: provider.selectedMonth,
        transactions: transactions,
        totalIncome: totalIncome,
        totalExpense: totalExpense,
        balance: balance,
        expensesByCategory: expensesByCategory,
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: AppColors.expense,
          ),
        );
      }
    }
  }
}