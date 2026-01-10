import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/budget_provider.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';
import '../widgets/transaction_card.dart';
import 'add_transaction_screen.dart';
import 'statistics_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Consumer<BudgetProvider>(
          builder: (context, provider, _) {
            final transactions = provider.getTransactionsForMonth(provider.selectedMonth);
            final totalIncome = provider.getTotalIncome(provider.selectedMonth);
            final totalExpense = provider.getTotalExpense(provider.selectedMonth);
            final balance = provider.getBalance(provider.selectedMonth);
            
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      _buildHeader(context, provider),
                      _buildBalanceCard(totalIncome, totalExpense, balance),
                      _buildActionButtons(context, provider),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Transaksi Terbaru',
                          style: AppTextStyles.headline2,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const StatisticsScreen(),
                              ),
                            );
                          },
                          child: const Text('Lihat Semua'),
                        ),
                      ],
                    ),
                  ),
                ),
                transactions.isEmpty
                    ? SliverFillRemaining(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.account_balance_wallet_outlined,
                                size: 80,
                                color: Colors.grey[300],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Belum ada transaksi',
                                style: AppTextStyles.subtitle1.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return TransactionCard(
                                transaction: transactions[index],
                                onDelete: () {
                                  _showDeleteDialog(
                                    context,
                                    provider,
                                    transactions[index].id,
                                  );
                                },
                              );
                            },
                            childCount: transactions.length,
                          ),
                        ),
                      ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 80),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddTransactionScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Transaksi'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
    );
  }
  
  Widget _buildHeader(BuildContext context, BudgetProvider provider) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'BudgetWise',
                style: AppTextStyles.headline1,
              ),
              const SizedBox(height: 4),
              Text(
                Helpers.formatMonth(provider.selectedMonth),
                style: AppTextStyles.subtitle2,
              ),
            ],
          ),
          Row(
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
        ],
      ),
    );
  }
  
  Widget _buildBalanceCard(double income, double expense, double balance) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, Color(0xFF8B7FFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Saldo',
            style: AppTextStyles.subtitle2.copyWith(
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            Helpers.formatCurrency(balance),
            style: AppTextStyles.headline1.copyWith(
              color: Colors.white,
              fontSize: 32,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildIncomeExpenseItem(
                  'Pemasukan',
                  income,
                  Icons.arrow_downward,
                  AppColors.income,
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.white30,
              ),
              Expanded(
                child: _buildIncomeExpenseItem(
                  'Pengeluaran',
                  expense,
                  Icons.arrow_upward,
                  AppColors.expense,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildIncomeExpenseItem(
    String label,
    double amount,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 16, color: color),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: Colors.white70,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          Helpers.formatCurrency(amount),
          style: AppTextStyles.subtitle1.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
  
  Widget _buildActionButtons(BuildContext context, BudgetProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const StatisticsScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.pie_chart),
              label: const Text('Statistik'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void _showDeleteDialog(
    BuildContext context,
    BudgetProvider provider,
    String transactionId,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Transaksi'),
        content: const Text('Apakah Anda yakin ingin menghapus transaksi ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              provider.deleteTransaction(transactionId);
              Navigator.pop(context);
            },
            child: const Text(
              'Hapus',
              style: TextStyle(color: AppColors.expense),
            ),
          ),
        ],
      ),
    );
  }
}