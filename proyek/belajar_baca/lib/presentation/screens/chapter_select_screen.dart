import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../providers/lesson_provider.dart';
import 'reader_screen.dart';

class ChapterSelectScreen extends StatelessWidget {
  const ChapterSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LessonProvider>();

    return Scaffold(
      backgroundColor: AppColors.homeBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.homeBackground,
            elevation: 0,
            expandedHeight: 140,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Bab Pelajaran', style: AppTextStyles.homeTitle.copyWith(fontSize: 22)),
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              background: Container(color: AppColors.homeBackground),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: AppColors.textDark),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final chapter = provider.chapters[index];
                  final progress = provider.getChapterProgress(index);
                  final gradColors = AppColors.chapterGradients[
                      chapter.gradientIndex % AppColors.chapterGradients.length];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _ChapterCard(
                      title: chapter.title,
                      subtitle: chapter.subtitle,
                      gradientColors: gradColors,
                      progress: progress,
                      total: chapter.totalCards,
                      onTap: () {
                        provider.openChapter(index);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ReaderScreen(),
                          ),
                        );
                      },
                    ),
                  );
                },
                childCount: provider.chapters.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChapterCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Color> gradientColors;
  final int progress;
  final int total;
  final VoidCallback onTap;

  const _ChapterCard({
    required this.title,
    required this.subtitle,
    required this.gradientColors,
    required this.progress,
    required this.total,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final pct = total > 0 ? (progress + 1) / total : 0.0;
    final isCompleted = progress >= total - 1 && total > 0;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.chapterCardBg,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: gradientColors[0].withAlpha(50),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Gradient icon
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      title.split('—').first.trim().substring(0, 1),
                      style: AppTextStyles.chapterLabel(Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Text info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: AppTextStyles.chapterTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 2),
                      Text(subtitle, style: AppTextStyles.chapterSubtitle),
                      const SizedBox(height: 8),
                      // Progress bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: pct,
                          backgroundColor: const Color(0xFFEEEEEE),
                          valueColor: AlwaysStoppedAnimation<Color>(
                              gradientColors[0]),
                          minHeight: 5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Arrow or check
                isCompleted
                    ? Icon(Icons.check_circle_rounded,
                        color: gradientColors[0], size: 28)
                    : Icon(Icons.play_circle_rounded,
                        color: gradientColors[0], size: 28),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
