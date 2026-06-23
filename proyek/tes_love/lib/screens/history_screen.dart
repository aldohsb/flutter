import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../models/quiz_result_model.dart';
import '../providers/user_provider.dart';
import '../utils/love_language_info.dart';
import '../utils/storage_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/user_avatar.dart';
import '../widgets/result_chart.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<QuizResultModel> _results = [];
  bool _isLoading = true;
  StorageService? _storage;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final user = context.read<UserProvider>().activeUser;
    if (user == null) return;
    _storage = await StorageService.create();
    final results = await _storage!.getResults(user.id);
    results.sort((a, b) => b.takenAt.compareTo(a.takenAt));
    if (mounted) {
      setState(() {
        _results = results;
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteResult(QuizResultModel result) async {
    final user = context.read<UserProvider>().activeUser;
    if (user == null || _storage == null) return;
    await _storage!.deleteResult(user.id, result.id);
    setState(() => _results.remove(result));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Hasil dihapus'),
          action: SnackBarAction(
            label: 'OK',
            textColor: AppColors.primaryLight,
            onPressed: () {},
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().activeUser;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Riwayat Quiz',
          style: AppTextStyles.headingMedium.copyWith(fontSize: 16),
        ),
        actions: [
          if (user != null)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: UserAvatar(name: user.name, size: 36),
            ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            )
          : _results.isEmpty
              ? _EmptyState(userName: user?.name ?? '')
              : _HistoryList(
                  results: _results,
                  onDelete: _deleteResult,
                ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String userName;
  const _EmptyState({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.history_rounded, size: 64, color: AppColors.textHint),
          const SizedBox(height: 16),
          Text(
            '$userName belum pernah mengikuti quiz.',
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Mulai quiz pertama kamu sekarang!',
            style: AppTextStyles.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Kembali ke Beranda'),
          ),
        ],
      ).animate().fadeIn(duration: 500.ms),
    );
  }
}

class _HistoryList extends StatelessWidget {
  final List<QuizResultModel> results;
  final Future<void> Function(QuizResultModel) onDelete;

  const _HistoryList({required this.results, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 48),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        return _HistoryCard(
          result: result,
          index: index,
          onDelete: () => onDelete(result),
        );
      },
    );
  }
}

class _HistoryCard extends StatefulWidget {
  final QuizResultModel result;
  final int index;
  final VoidCallback onDelete;

  const _HistoryCard({
    required this.result,
    required this.index,
    required this.onDelete,
  });

  @override
  State<_HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<_HistoryCard> {
  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final result = widget.result;
    final primary = result.primaryLanguage;
    final primaryInfo = LoveLanguageInfo.of(primary);
    final ranked = result.ranking;
    final total = result.totalScore;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
        boxShadow: const [
          BoxShadow(color: AppColors.shadow, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header berwarna
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: primaryInfo.color.withAlpha(18),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Text(primary.emoji, style: const TextStyle(fontSize: 28)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        primaryInfo.title,
                        style: AppTextStyles.headingMedium.copyWith(
                          fontSize: 15,
                          color: primaryInfo.color,
                        ),
                      ),
                      Text(
                        _formatDate(result.takenAt),
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
                // Delete button
                IconButton(
                  onPressed: _confirmDelete,
                  icon: const Icon(Icons.delete_outline_rounded, size: 20),
                  color: AppColors.textHint,
                  tooltip: 'Hapus hasil ini',
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mini ranking
                ...List.generate(ranked.length, (i) {
                  final entry = ranked[i];
                  final info = LoveLanguageInfo.of(entry.key);
                  final pct = total > 0 ? entry.value / total : 0.0;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                          child: Text(
                            '${i + 1}',
                            style: AppTextStyles.caption.copyWith(
                              color: i == 0 ? info.color : AppColors.textHint,
                              fontWeight: i == 0 ? FontWeight.w700 : FontWeight.w400,
                            ),
                          ),
                        ),
                        Text(info.language.emoji, style: const TextStyle(fontSize: 14)),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            info.language.shortLabel,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(99),
                            child: LinearProgressIndicator(
                              value: pct,
                              minHeight: 5,
                              backgroundColor: info.color.withAlpha(25),
                              valueColor: AlwaysStoppedAnimation<Color>(info.color),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${entry.value}',
                          style: AppTextStyles.caption.copyWith(
                            color: info.color,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                const Divider(height: 20),

                // Toggle chart
                GestureDetector(
                  onTap: () => setState(() => _showChart = !_showChart),
                  child: Row(
                    children: [
                      Text(
                        _showChart ? 'Sembunyikan chart' : 'Lihat chart skor',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      const Spacer(),
                      AnimatedRotation(
                        turns: _showChart ? 0.5 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),

                AnimatedCrossFade(
                  firstChild: const SizedBox.shrink(),
                  secondChild: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: ResultChart(scores: result.scores, totalQuestions: total),
                  ),
                  crossFadeState: _showChart
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 300),
                ),
              ],
            ),
          ),
        ],
      ),
    )
        .animate(key: ValueKey('hist_${widget.index}'))
        .fadeIn(duration: 400.ms, delay: (widget.index * 60).ms)
        .slideY(begin: 0.06, end: 0, duration: 400.ms, delay: (widget.index * 60).ms);
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Hapus Hasil?', style: AppTextStyles.headingMedium),
        content: Text(
          'Hasil quiz ini akan dihapus permanen.',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Batal', style: AppTextStyles.bodyMedium),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              widget.onDelete();
            },
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt) {
    const months = [
      '', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
    ];
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '${dt.day} ${months[dt.month]} ${dt.year}, $h:$m';
  }
}