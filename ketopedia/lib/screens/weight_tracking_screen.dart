import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/weight_entry_model.dart';
import '../providers/weight_provider.dart';
import '../providers/user_provider.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';
import '../widgets/weight_chart.dart';
import '../widgets/stat_card.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class WeightTrackingScreen extends StatefulWidget {
  const WeightTrackingScreen({super.key});

  @override
  State<WeightTrackingScreen> createState() => _WeightTrackingScreenState();
}

class _WeightTrackingScreenState extends State<WeightTrackingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tracking Berat Badan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _exportData,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddWeightDialog,
        child: const Icon(Icons.add),
      ),
      body: Consumer2<WeightProvider, UserProvider>(
        builder: (context, weightProvider, userProvider, child) {
          if (weightProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = userProvider.user;
          if (user == null) {
            return const Center(child: Text('User data not found'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStats(weightProvider, user),
                const SizedBox(height: 24),
                _buildChart(weightProvider, user),
                const SizedBox(height: 24),
                _buildHistory(weightProvider),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStats(WeightProvider weightProvider, userModel) {
    final totalChange = weightProvider.totalWeightChange ?? 0;
    final avgWeekly = weightProvider.getAverageWeightLoss() ?? 0;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CompactStatCard(
                label: 'Total Turun',
                value: '${totalChange.abs().toStringAsFixed(1)} kg',
                icon: Icons.trending_down,
                color: totalChange < 0
                    ? AppConstants.ratingExcellent
                    : AppConstants.ratingAvoid,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CompactStatCard(
                label: 'Per Minggu',
                value: '${avgWeekly.abs().toStringAsFixed(2)} kg',
                icon: Icons.speed,
                color: AppConstants.accentYellow,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChart(WeightProvider weightProvider, userModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Grafik Progress',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: WeightChart(
                entries: weightProvider.getEntriesForChart(),
                targetWeight: userModel.targetWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistory(WeightProvider weightProvider) {
    final entries = weightProvider.entries;

    if (entries.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
          child: Center(
            child: Column(
              children: [
                const Icon(
                  Icons.history,
                  size: 64,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                Text(
                  'Belum ada data berat badan',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                const Text('Tap tombol + untuk menambah data'),
              ],
            ),
          ),
        ),
      );
    }

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child: Text(
              'Riwayat',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: entries.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final entry = entries[index];
              final change = index < entries.length - 1
                  ? entry.weight - entries[index + 1].weight
                  : 0.0;

              return ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppConstants.primaryRed.withOpacity(0.1),
                    borderRadius:
                        BorderRadius.circular(AppConstants.radiusSmall),
                  ),
                  child: const Icon(
                    Icons.monitor_weight,
                    color: AppConstants.primaryRed,
                  ),
                ),
                title: Text(
                  Helpers.formatWeight(entry.weight),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Helpers.formatDate(entry.date)),
                    if (entry.notes != null && entry.notes!.isNotEmpty)
                      Text(entry.notes!,
                          style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                trailing: index < entries.length - 1
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: change < 0
                              ? AppConstants.ratingExcellent.withOpacity(0.1)
                              : AppConstants.ratingAvoid.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            AppConstants.radiusSmall,
                          ),
                        ),
                        child: Text(
                          '${change >= 0 ? '+' : ''}${change.toStringAsFixed(1)} kg',
                          style: TextStyle(
                            color: change < 0
                                ? AppConstants.ratingExcellent
                                : AppConstants.ratingAvoid,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : null,
                onLongPress: () => _showDeleteDialog(entry),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showAddWeightDialog() async {
    final weightController = TextEditingController();
    final notesController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Data Berat'),
        content: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                label: 'Berat Badan (kg)',
                hint: '70.5',
                controller: weightController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                prefixIcon: Icons.monitor_weight,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Tanggal'),
                subtitle: Text(Helpers.formatDate(selectedDate)),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() => selectedDate = date);
                  }
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Catatan (Opsional)',
                hint: 'Tulis catatan...',
                controller: notesController,
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          CustomButton(
            text: 'Simpan',
            onPressed: () async {
              final weight = double.tryParse(weightController.text);
              if (weight == null) {
                Helpers.showSnackBar(
                  context,
                  'Berat badan tidak valid',
                  isError: true,
                );
                return;
              }

              final userProvider = context.read<UserProvider>();
              final entry = WeightEntryModel(
                userId: userProvider.user!.id!,
                weight: weight,
                date: selectedDate,
                notes: notesController.text.trim().isEmpty
                    ? null
                    : notesController.text.trim(),
              );

              final success =
                  await context.read<WeightProvider>().addEntry(entry);

              if (success && context.mounted) {
                // Update user current weight
                await userProvider.updateCurrentWeight(weight);
                Navigator.pop(context);
                Helpers.showSnackBar(context, 'Data berhasil ditambahkan!');
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showDeleteDialog(WeightEntryModel entry) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Data?'),
        content: Text(
          'Yakin ingin menghapus data ${Helpers.formatWeight(entry.weight)} pada ${Helpers.formatDate(entry.date)}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: AppConstants.primaryRed,
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      final success =
          await context.read<WeightProvider>().deleteEntry(entry.id!);
      if (success && mounted) {
        Helpers.showSnackBar(context, 'Data berhasil dihapus');
      }
    }
  }

  Future<void> _exportData() async {
    final userProvider = context.read<UserProvider>();
    final weightProvider = context.read<WeightProvider>();

    if (userProvider.user == null) return;

    final success = await weightProvider.exportData(userProvider.user!);

    if (success && mounted) {
      Helpers.showSnackBar(context, 'Data berhasil di-export!');
    } else if (mounted) {
      Helpers.showSnackBar(
        context,
        'Gagal export data',
        isError: true,
      );
    }
  }
}
