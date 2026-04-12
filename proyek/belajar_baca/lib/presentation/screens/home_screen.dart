import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../providers/lesson_provider.dart';
import 'chapter_select_screen.dart';
import 'reader_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LessonProvider>();
    final totalChapters = provider.chapters.length;
    int completedChapters = 0;
    for (int i = 0; i < totalChapters; i++) {
      if (provider.getChapterProgress(i) >= provider.chapters[i].totalCards - 1) {
        completedChapters++;
      }
    }

    return Scaffold(
      backgroundColor: AppColors.homeBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              // ── Header ────────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Belajar\nBaca', style: AppTextStyles.homeTitle),
                        const SizedBox(height: 6),
                        Text(
                          'Metode suku kata untuk anak TK',
                          style: AppTextStyles.homeSubtitle,
                        ),
                      ],
                    ),
                  ),
                  _EmojiWidget(),
                ],
              ),

              const SizedBox(height: 32),

              // ── Stats Card ────────────────────────────────────────
              _StatsCard(
                completed: completedChapters,
                total: totalChapters,
              ),

              const SizedBox(height: 32),

              // ── Action Buttons ────────────────────────────────────
              _ActionButton(
                label: 'Mulai Belajar',
                icon: Icons.play_arrow_rounded,
                gradientColors: AppColors.chapterGradients[0],
                onTap: () {
                  // Resume last chapter or start from first
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const ReaderScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 14),
              _ActionButton(
                label: 'Pilih Bab',
                icon: Icons.menu_book_rounded,
                gradientColors: AppColors.chapterGradients[1],
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const ChapterSelectScreen(),
                    ),
                  );
                },
              ),

              const Spacer(),

              // ── Bottom hint ───────────────────────────────────────
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Text(
                    'Geser kartu ke kanan / kiri untuk berpindah',
                    style: AppTextStyles.homeSubtitle
                        .copyWith(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmojiWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.chapterGradients[0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.chapterGradients[0][0].withAlpha(80),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Center(
        child: Text('📖', style: TextStyle(fontSize: 38)),
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  final int completed;
  final int total;

  const _StatsCard({required this.completed, required this.total});

  @override
  Widget build(BuildContext context) {
    final pct = total > 0 ? completed / total : 0.0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(18),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Progres Belajar',
                  style: AppTextStyles.chapterTitle.copyWith(fontSize: 16)),
              Text('$completed / $total bab',
                  style: AppTextStyles.chapterSubtitle),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: pct,
              backgroundColor: const Color(0xFFEEEEEE),
              valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.homePrimary),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final List<Color> gradientColors;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.gradientColors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          height: 64,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: gradientColors[0].withAlpha(80),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 28),
                const SizedBox(width: 16),
                Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'Baloo2',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.chevron_right_rounded,
                    color: Colors.white, size: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
