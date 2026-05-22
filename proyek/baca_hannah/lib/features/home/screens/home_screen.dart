// lib/features/home/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../app_router.dart';
import '../../../core/constants/color_constants.dart';
import '../../../data/repositories/chapter_repository.dart';
import '../../../data/repositories/progress_repository.dart';
import '../widgets/chapter_card.dart';
import '../widgets/header_widget.dart';
import '../widgets/progress_badge.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final chapterRepo = context.read<ChapterRepository>();
    final progressRepo = context.read<ProgressRepository>();

    final chapters = chapterRepo.getAllChapters();
    final allProgress = progressRepo.getAllProgress();
    final completedCount =
        allProgress.where((p) => p.isCompleted).length;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // ── Header ──────────────────────────────────────
          const HomeHeaderWidget(),

          // ── Scrollable content ──────────────────────────
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => setState(() {}),
              color: AppColors.primary,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // Progress badge
                    ProgressBadge(
                      completedChapters: completedCount,
                      totalChapters: chapters.length,
                    ),

                    const SizedBox(height: 24),

                    // Label grid
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          Text(
                            '📚 Daftar Bab',
                            style: GoogleFonts.nunito(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const Spacer(),
                          // Tombol progres
                          GestureDetector(
                            onTap: () => context.push(AppRouter.progress),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Lihat Semua',
                                style: GoogleFonts.nunito(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Grid bab
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.82,
                        ),
                        itemCount: chapters.length,
                        itemBuilder: (context, index) {
                          final chapter = chapters[index];
                          final progress = allProgress.firstWhere(
                            (p) => p.chapterId == chapter.id,
                            orElse: () => progressRepo.getProgress(chapter.id),
                          );
                          return ChapterCard(
                            chapter: chapter,
                            progress: progress,
                            animationIndex: index,
                            onTap: () {
                              final startPage =
                                  progress.lastPageReached > 0 &&
                                          !progress.isCompleted
                                      ? progress.lastPageReached
                                      : 0;
                              context.push(
                                AppRouter.readingPath(chapter.id),
                                extra: {'startPage': startPage},
                              );
                            },
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Footer fun
                    Center(
                      child: Text(
                        '🌟 Semangat belajar! 🌟',
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textLight,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}