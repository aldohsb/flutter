import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../widgets/chart_widget.dart';
import '../widgets/empty_state_widget.dart';
import '../utils/app_theme.dart';
import '../utils/helpers.dart';
import '../services/export_service.dart';

class MonthlyReportScreen extends StatefulWidget {
  const MonthlyReportScreen({super.key});

  @override
  State<MonthlyReportScreen> createState() => _MonthlyReportScreenState();
}

class _MonthlyReportScreenState extends State<MonthlyReportScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isExporting = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan Bulanan'),
        actions: [
          IconButton(
            icon: _isExporting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.file_download),
            onPressed: _isExporting ? null : _exportReport,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.primaryColor,
          labelColor: AppTheme.primaryColor,
          unselectedLabelColor: AppTheme.textSecondary,
          tabs: const [
            Tab(text: 'Pengeluaran'),
            Tab(text: 'Pemasukan'),
          ],
        ),
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          return FutureBuilder<List<double>>(
            future: Future.wait([
              provider.getTotalIncome(),
              provider.getTotalExpense(),
              provider.getBalance(),
            ]),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final income = snapshot.data![0];
              final expense = snapshot.data![1];
              final balance = snapshot.data![2];

              return Column(
                children: [
                  // Summary Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primaryColor,
                          AppTheme.secondaryColor,
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          Helpers.formatMonthYear(provider.selectedMonth),
                          style: AppTheme.bodyLarge.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Saldo: ${Helpers.formatCurrency(balance)}',
                          style: AppTheme.headingLarge.copyWith(
                            color: Colors.white,
                            fontSize: 28,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _SummaryItem(
                              label: 'Pemasukan',
                              value: Helpers.formatCurrency(income),
                              color: AppTheme.incomeColor,
                            ),
                            Container(
                              width: 1,
                              height: 40,
                              color: Colors.white.withOpacity(0.3),
                            ),
                            _SummaryItem(
                              label: 'Pengeluaran',
                              value: Helpers.formatCurrency(expense),
                              color: AppTheme.expenseColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Chart and Legend
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildChartTab(provider, 'expense'),
                        _buildChartTab(provider, 'income'),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildChartTab(TransactionProvider provider, String type) {
    final categoryData = provider.getCategoryTotals(type);

    if (categoryData.isEmpty) {
      return EmptyStateWidget(
        title: 'Belum Ada Data',
        message: 'Belum ada ${type == 'income' ? 'pemasukan' : 'pengeluaran'} bulan ini',
        emoji: type == 'income' ? '💰' : '💸',
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Chart
          ChartWidget(data: categoryData, type: type),
          
          const SizedBox(height: 32),
          
          // Legend
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Detail Kategori',
              style: AppTheme.headingSmall,
            ),
          ),
          
          const SizedBox(height: 16),
          
          ChartLegend(data: categoryData, type: type),
        ],
      ),
    );
  }

  Future<void> _exportReport() async {
    setState(() => _isExporting = true);

    try {
      final provider = context.read<TransactionProvider>();
      final exportService = ExportService();

      final filePath = await exportService.exportToPDF(
        transactions: provider.transactions,
        month: provider.selectedMonth,
        totalIncome: await provider.getTotalIncome(),
        totalExpense: await provider.getTotalExpense(),
        balance: await provider.getBalance(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Laporan tersimpan: $filePath'),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppTheme.expenseColor,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isExporting = false);
      }
    }
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _SummaryItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            label == 'Pemasukan' ? Icons.arrow_downward : Icons.arrow_upward,
            color: color,
            size: 20,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTheme.bodyMedium.copyWith(
            color: Colors.white.withOpacity(0.9),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTheme.bodyLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}