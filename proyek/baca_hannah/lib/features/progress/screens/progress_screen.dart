// lib/features/progress/screens/progress_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/color_constants.dart';
import '../../../data/repositories/chapter_repository.dart';
import '../../../data/repositories/progress_repository.dart';
import '../widgets/progress_card.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  Future<void> _confirmReset(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: Text(
          'Reset Semua Progres?',
          style: GoogleFonts.nunito(fontWeight: FontWeight.w800),
        ),
        content: Text(
          'Semua catatan belajar akan dihapus. Yakin?',
          style: GoogleFonts.nunito(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text('Batal',
                style: GoogleFonts.nunito(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child:
                Text('Reset', style: GoogleFonts.nunito(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final progressRepo = context.read<ProgressRepository>();
      await progressRepo.resetAll();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final chapterRepo = context.read<ChapterRepository>();
    final progressRepo = context.read<ProgressRepository>();

    final chapters = chapterRepo.getAllChapters();
    final allProgress = progressRepo.getAllProgress();
    final completedCount = allProgress.where((p) => p.isCompleted).length;
    final totalStars = allProgress.fold<int>(0, (sum, p) => sum + p.stars);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // App bar
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.pop(),
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          size: 18, color: AppColors.textPrimary),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '📊 Progres Belajar',
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // Tombol reset
                  IconButton(
                    onPressed: () => _confirmReset(context),
                    icon: const Icon(Icons.refresh_rounded,
                        color: AppColors.textSecondary),
                    tooltip: 'Reset progres',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Summary card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    _SummaryStat(
                      label: 'Bab Selesai',
                      value: '$completedCount/${chapters.length}',
                      emoji: '📚',
                    ),
                    Container(
                      width: 1,
                      height: 50,
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                    _SummaryStat(
                      label: 'Total Bintang',
                      value: '$totalStars ⭐',
                      emoji: '🏆',
                    ),
                    Container(
                      width: 1,
                      height: 50,
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                    _SummaryStat(
                      label: 'Semangat',
                      value: completedCount == chapters.length ? '🔥' : '💪',
                      emoji: '',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'Detail per Bab',
              style: GoogleFonts.nunito(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textSecondary,
              ),
            ),

            const SizedBox(height: 12),

            // Daftar progress
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: chapters.length,
                itemBuilder: (context, index) {
                  final chapter = chapters[index];
                  final progress = allProgress.firstWhere(
                    (p) => p.chapterId == chapter.id,
                    orElse: () => progressRepo.getProgress(chapter.id),
                  );
                  return ProgressCard(
                    chapter: chapter,
                    progress: progress,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryStat extends StatelessWidget {
  final String label;
  final String value;
  final String emoji;

  const _SummaryStat({
    required this.label,
    required this.value,
    required this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.nunito(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.nunito(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.85),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}