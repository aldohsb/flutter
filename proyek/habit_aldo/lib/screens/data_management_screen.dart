import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';

import '../providers/habit_provider.dart';
import '../providers/weight_provider.dart';
import '../providers/earning_provider.dart';
import '../theme/app_theme.dart';

class DataManagementScreen extends StatelessWidget {
  const DataManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.sage100,
      appBar: AppBar(title: const Text('Kelola Data')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _SectionHeader(title: 'Export'),
          const SizedBox(height: 8),
          _ActionCard(
            icon: Icons.upload_file_rounded,
            title: 'Export Semua Data',
            subtitle: 'Simpan habits, berat badan, dan earning ke file JSON',
            color: AppTheme.sage600,
            onTap: () => _exportAll(context),
          ),
          const SizedBox(height: 16),
          const _SectionHeader(title: 'Import'),
          const SizedBox(height: 8),
          _ActionCard(
            icon: Icons.download_rounded,
            title: 'Import Data',
            subtitle: 'Muat data dari file JSON (akan mengganti data saat ini)',
            color: AppTheme.warningAmber,
            onTap: () => _importAll(context),
          ),
          const SizedBox(height: 24),

          // ── Danger zone ──
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.errorRed.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.errorRed.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('⚠ Berbahaya',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: AppTheme.errorRed)),
                const SizedBox(height: 8),
                Text(
                  'Import akan menimpa semua data yang ada. Pastikan kamu sudah export backup sebelum import.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppTheme.errorRed),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          const _SectionHeader(title: 'Info Aplikasi'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.sage200),
            ),
            child: Column(
              children: [
                const _InfoRow(label: 'Versi', value: '1.0.0'),
                const Divider(height: 16),
                Consumer<HabitProvider>(
                  builder: (_, hp, __) => _InfoRow(
                      label: 'Total Habit',
                      value: '${hp.habits.length}'),
                ),
                const Divider(height: 16),
                Consumer<WeightProvider>(
                  builder: (_, wp, __) => _InfoRow(
                      label: 'Data Berat Badan',
                      value: '${wp.entries.length} entri'),
                ),
                const Divider(height: 16),
                Consumer<EarningProvider>(
                  builder: (_, ep, __) => _InfoRow(
                      label: 'Data Earning',
                      value: '${ep.entries.length} entri'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _exportAll(BuildContext context) async {
    final hp = context.read<HabitProvider>();
    final wp = context.read<WeightProvider>();
    final ep = context.read<EarningProvider>();

    final data = {
      'exportedAt': DateTime.now().toIso8601String(),
      'version': '1.0.0',
      'habits': hp.exportData(),
      'weight': wp.exportData(),
      'earning': ep.exportData(),
    };

    final jsonStr = const JsonEncoder.withIndent('  ').convert(data);
    final fileName =
        'habit_aldo_${DateFormat('yyyyMMdd_HHmm').format(DateTime.now())}.json';

    try {
      if (kIsWeb) {
        // Web: use share_plus
        await Share.share(jsonStr, subject: fileName);
      } else {
        // Mobile/Desktop: save to temp then share
        final dir = await getTemporaryDirectory();
        final file = File('${dir.path}/$fileName');
        await file.writeAsString(jsonStr);
        await Share.shareXFiles([XFile(file.path)], subject: fileName);
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil di-export')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal export: $e')),
        );
      }
    }
  }

  Future<void> _importAll(BuildContext context) async {
    // Confirm first
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.stone100,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Import Data?'),
        content: const Text(
            'Semua data saat ini akan digantikan dengan data dari file. Lanjutkan?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Batal')),
          ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: AppTheme.warningAmber),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Ya, Import'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result == null || result.files.isEmpty) return;
      if (!context.mounted) return;

      String jsonStr;
      if (kIsWeb) {
        final bytes = result.files.first.bytes;
        if (bytes == null) throw Exception('File tidak bisa dibaca');
        jsonStr = utf8.decode(bytes);
      } else {
        final path = result.files.first.path;
        if (path == null) throw Exception('Path tidak valid');
        jsonStr = await File(path).readAsString();
      }

      final data = jsonDecode(jsonStr) as Map<String, dynamic>;

      final hp = context.read<HabitProvider>();
      final wp = context.read<WeightProvider>();
      final ep = context.read<EarningProvider>();

      if (data['habits'] != null) {
        await hp.importData(data['habits'] as Map<String, dynamic>);
      }
      if (data['weight'] != null) {
        await wp.importData(data['weight'] as Map<String, dynamic>);
      }
      if (data['earning'] != null) {
        await ep.importData(data['earning'] as Map<String, dynamic>);
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil di-import')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal import: $e')),
        );
      }
    }
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: AppTheme.sage600,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.sage200),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: Theme.of(context).textTheme.titleMedium),
                    Text(subtitle,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded,
                  color: AppTheme.stone300),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Text(value,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
