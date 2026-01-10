import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../database/app_database.dart';
import '../providers/transaction_provider.dart';
import '../utils/app_theme.dart';
import '../utils/helpers.dart';
import '../utils/constants.dart';
import '../widgets/category_chip.dart';

class AddTransactionScreen extends StatefulWidget {
  final Transaction? transaction;

  const AddTransactionScreen({super.key, this.transaction});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String _selectedType = AppConstants.typeExpense;
  String? _selectedCategory;
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.transaction != null) {
      _loadTransaction();
    }
  }

  void _loadTransaction() {
    final transaction = widget.transaction!;
    _selectedType = transaction.type;
    _amountController.text = transaction.amount.toString();
    _selectedCategory = transaction.category;
    _descriptionController.text = transaction.description;
    _selectedDate = transaction.date;
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = _selectedType == AppConstants.typeIncome
        ? AppConstants.incomeCategories
        : AppConstants.expenseCategories;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.transaction == null ? 'Tambah Transaksi' : 'Edit Transaksi'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Type Selector
            Row(
              children: [
                Expanded(
                  child: _TypeButton(
                    label: 'Pengeluaran',
                    icon: '💸',
                    color: AppTheme.expenseColor,
                    isSelected: _selectedType == AppConstants.typeExpense,
                    onTap: () {
                      setState(() {
                        _selectedType = AppConstants.typeExpense;
                        _selectedCategory = null;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _TypeButton(
                    label: 'Pemasukan',
                    icon: '💰',
                    color: AppTheme.incomeColor,
                    isSelected: _selectedType == AppConstants.typeIncome,
                    onTap: () {
                      setState(() {
                        _selectedType = AppConstants.typeIncome;
                        _selectedCategory = null;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Amount Field
            TextFormField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Nominal',
                prefixText: AppConstants.currency,
                prefixIcon: Icon(
                  Icons.money,
                  color: _selectedType == AppConstants.typeIncome
                      ? AppTheme.incomeColor
                      : AppTheme.expenseColor,
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: Helpers.validateAmount,
            ),

            const SizedBox(height: 20),

            // Category Selector
            Text(
              'Kategori',
              style: AppTheme.headingSmall,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: categories.map((category) {
                return CategoryChip(
                  name: category['name'] as String,
                  icon: category['icon'] as String,
                  color: Color(category['color'] as int),
                  isSelected: _selectedCategory == category['name'],
                  onTap: () {
                    setState(() {
                      _selectedCategory = category['name'] as String;
                    });
                  },
                );
              }).toList(),
            ),

            if (_selectedCategory == null) ...[
              const SizedBox(height: 8),
              Text(
                'Pilih kategori terlebih dahulu',
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.expenseColor,
                  fontSize: 12,
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Description Field
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Keterangan',
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 3,
              validator: Helpers.validateDescription,
            ),

            const SizedBox(height: 20),

            // Date Picker
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.accentColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.calendar_today,
                  color: AppTheme.accentColor,
                ),
              ),
              title: const Text('Tanggal'),
              subtitle: Text(Helpers.formatDate(_selectedDate)),
              trailing: const Icon(Icons.chevron_right),
              onTap: _selectDate,
            ),

            const SizedBox(height: 32),

            // Submit Button
            ElevatedButton(
              onPressed: _isLoading ? null : _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: _selectedType == AppConstants.typeIncome
                    ? AppTheme.incomeColor
                    : AppTheme.expenseColor,
                minimumSize: const Size(double.infinity, 54),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      widget.transaction == null ? 'Simpan' : 'Update',
                      style: AppTheme.labelLarge,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: _selectedType == AppConstants.typeIncome
                  ? AppTheme.incomeColor
                  : AppTheme.expenseColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih kategori terlebih dahulu'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final provider = context.read<TransactionProvider>();
      final amount = double.parse(_amountController.text);

      if (widget.transaction == null) {
        await provider.addTransaction(
          type: _selectedType,
          amount: amount,
          category: _selectedCategory!,
          description: _descriptionController.text,
          date: _selectedDate,
        );
      } else {
        await provider.updateTransaction(
          id: widget.transaction!.id,
          type: _selectedType,
          amount: amount,
          category: _selectedCategory!,
          description: _descriptionController.text,
          date: _selectedDate,
          createdAt: widget.transaction!.createdAt,
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.transaction == null
                ? 'Transaksi berhasil ditambahkan'
                : 'Transaksi berhasil diupdate'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.pop(context);
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
        setState(() => _isLoading = false);
      }
    }
  }
}

class _TypeButton extends StatelessWidget {
  final String label;
  final String icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _TypeButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: isSelected ? color : color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : color.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Text(
              icon,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppTheme.bodyMedium.copyWith(
                color: isSelected ? Colors.white : AppTheme.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}