import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../utils/app_theme.dart';
import '../utils/helpers.dart';
import '../utils/constants.dart';
import '../widgets/summary_card.dart';
import '../widgets/transaction_card.dart';
import '../widgets/empty_state_widget.dart';
import 'add_transaction_screen.dart';
import 'monthly_report_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<TransactionProvider>(
          builder: (context, provider, child) {
            return RefreshIndicator(
              onRefresh: () => provider.loadTransactions(),
              child: CustomScrollView(
                slivers: [
                  // App Bar
                  SliverAppBar(
                    floating: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: Column(
                      children: [
                        Text(
                          '💰 CashFlow',
                          style: AppTheme.headingMedium.copyWith(
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        Text(
                          Helpers.formatMonthYear(provider.selectedMonth),
                          style: AppTheme.bodyMedium,
                        ),
                      ],
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: () {
                          final newMonth = DateTime(
                            provider.selectedMonth.year,
                            provider.selectedMonth.month - 1,
                          );
                          provider.changeMonth(newMonth);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: () {
                          final newMonth = DateTime(
                            provider.selectedMonth.year,
                            provider.selectedMonth.month + 1,
                          );
                          provider.changeMonth(newMonth);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.pie_chart_rounded),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MonthlyReportScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  // Summary Cards
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: FutureBuilder<List<double>>(
                        future: Future.wait([
                          provider.getTotalIncome(),
                          provider.getTotalExpense(),
                          provider.getBalance(),
                        ]),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          final income = snapshot.data![0];
                          final expense = snapshot.data![1];
                          final balance = snapshot.data![2];

                          return Column(
                            children: [
                              // Balance Card (Big)
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppTheme.primaryColor,
                                      AppTheme.secondaryColor,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppTheme.primaryColor.withOpacity(0.3),
                                      blurRadius: 15,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Saldo',
                                      style: AppTheme.bodyLarge.copyWith(
                                        color: Colors.white.withOpacity(0.9),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      Helpers.formatCurrency(balance),
                                      style: AppTheme.headingLarge.copyWith(
                                        color: Colors.white,
                                        fontSize: 36,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 16),

                              // Income & Expense Cards
                              Row(
                                children: [
                                  Expanded(
                                    child: SummaryCard(
                                      title: 'Pemasukan',
                                      amount: income,
                                      color: AppTheme.incomeColor,
                                      icon: Icons.arrow_downward,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: SummaryCard(
                                      title: 'Pengeluaran',
                                      amount: expense,
                                      color: AppTheme.expenseColor,
                                      icon: Icons.arrow_upward,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),

                  // Transactions List
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Transaksi',
                            style: AppTheme.headingSmall,
                          ),
                          Text(
                            '${provider.transactions.length} transaksi',
                            style: AppTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 16)),

                  // Transaction List
                  provider.isLoading
                      ? const SliverFillRemaining(
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : provider.transactions.isEmpty
                          ? const SliverFillRemaining(
                              child: EmptyStateWidget(
                                title: AppConstants.emptyTransactionTitle,
                                message: AppConstants.emptyTransactionMessage,
                                emoji: '📝',
                              ),
                            )
                          : SliverPadding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                              sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    final transaction = provider.transactions[index];
                                    return TransactionCard(
                                      transaction: transaction,
                                      onTap: () {
                                        _editTransaction(context, transaction);
                                      },
                                      onDelete: () {
                                        provider.deleteTransaction(transaction.id);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Transaksi dihapus'),
                                            behavior: SnackBarBehavior.floating,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  childCount: provider.transactions.length,
                                ),
                              ),
                            ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTransactionScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Tambah'),
      ),
    );
  }

  void _editTransaction(BuildContext context, transaction) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTransactionScreen(
          transaction: transaction,
        ),
      ),
    );
  }
}