// lib/features/reading/screens/reading_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/color_constants.dart';
import '../../../data/models/chapter_model.dart';
import '../../../data/models/progress_model.dart';
import '../../../data/repositories/progress_repository.dart';
import '../widgets/navigation_controls.dart';
import '../widgets/page_indicator.dart';
import '../widgets/syllable_display.dart';

class ReadingScreen extends StatefulWidget {
  final ChapterModel chapter;
  final int startPageIndex; // 0-based

  const ReadingScreen({
    super.key,
    required this.chapter,
    this.startPageIndex = 0,
  });

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  late PageController _pageController;
  late int _currentIndex;
  final bool _isAnimating = false;
  late ChapterProgress _progress;
  bool _showCelebration = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.startPageIndex
        .clamp(0, widget.chapter.totalPages - 1);
    _pageController = PageController(initialPage: _currentIndex);

    final progressRepo = context.read<ProgressRepository>();
    _progress = progressRepo.getProgress(widget.chapter.id);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int index) {
    if (_isAnimating) return;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
    );
  }

  void _onPageChanged(int index) async {
    setState(() => _currentIndex = index);

    // Simpan progress
    final progressRepo = context.read<ProgressRepository>();
    final pageNumber = index + 1; // 1-based
    _progress = await progressRepo.updatePage(widget.chapter.id, pageNumber);
  }

  void _onFinish() async {
    final progressRepo = context.read<ProgressRepository>();
    _progress = await progressRepo.updatePage(
      widget.chapter.id,
      widget.chapter.totalPages,
    );

    setState(() => _showCelebration = true);

    await Future.delayed(const Duration(milliseconds: 2000));
    if (mounted) {
      setState(() => _showCelebration = false);
      context.pop();
    }
  }

  Color get _accentColor =>
      AppColors.chapterColor(widget.chapter.index);

  @override
  Widget build(BuildContext context) {
    final chapter = widget.chapter;
    final isLastPage = _currentIndex == chapter.totalPages - 1;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ── Background dekorasi ──────────────────────────
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: _accentColor.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            left: -40,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: _accentColor.withValues(alpha: 0.06),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // ── Konten utama ─────────────────────────────────
          SafeArea(
            child: Column(
              children: [
                // App bar custom
                _buildAppBar(context, chapter),

                const SizedBox(height: 8),

                // Page indicator
                PageIndicator(
                  currentIndex: _currentIndex,
                  totalPages: chapter.totalPages,
                  activeColor: _accentColor,
                ),

                const SizedBox(height: 24),

                // PageView suku kata
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: chapter.totalPages,
                    itemBuilder: (context, index) {
                      final page = chapter.pages[index];
                      return Center(
                        child: SyllableDisplay(
                          page: page,
                          isAnimating: index == _currentIndex,
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Navigasi
                NavigationControls(
                  canGoPrev: _currentIndex > 0,
                  canGoNext: _currentIndex < chapter.totalPages - 1,
                  isLastPage: isLastPage,
                  onPrev: () => _goToPage(_currentIndex - 1),
                  onNext: () => _goToPage(_currentIndex + 1),
                  onFinish: _onFinish,
                  accentColor: _accentColor,
                ),

                const SizedBox(height: 24),

                // Hint swipe
                Text(
                  '← Geser untuk berpindah halaman →',
                  style: GoogleFonts.nunito(
                    fontSize: 12,
                    color: AppColors.textLight,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),

          // ── Celebration overlay ───────────────────────────
          if (_showCelebration)
            _CelebrationOverlay(chapterTheme: chapter.theme),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, ChapterModel chapter) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
      child: Row(
        children: [
          // Tombol kembali
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
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Info bab
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chapter.title,
                  style: GoogleFonts.nunito(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  '${chapter.emoji}  ${chapter.theme}',
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: _accentColor,
                  ),
                ),
              ],
            ),
          ),
          // Bintang progres
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${_progress.stars} ⭐',
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.accentDark,
                ),
              ),
              Text(
                '${_progress.lastPageReached}/${chapter.totalPages}',
                style: GoogleFonts.nunito(
                  fontSize: 12,
                  color: AppColors.textLight,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Celebration Overlay
// ─────────────────────────────────────────────────────────────
class _CelebrationOverlay extends StatelessWidget {
  final String chapterTheme;

  const _CelebrationOverlay({required this.chapterTheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.6),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          padding: const EdgeInsets.all(36),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 32,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🎉', style: TextStyle(fontSize: 64))
                  .animate(onPlay: (c) => c.repeat())
                  .scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1.2, 1.2),
                    duration: 600.ms,
                    curve: Curves.easeInOut,
                  )
                  .then()
                  .scale(
                    begin: const Offset(1.2, 1.2),
                    end: const Offset(0.8, 0.8),
                    duration: 600.ms,
                    curve: Curves.easeInOut,
                  ),
              const SizedBox(height: 16),
              Text(
                'Hebat sekali!',
                style: GoogleFonts.nunito(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Kamu sudah selesai\nbelajar "$chapterTheme"! 🌟',
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star_rounded,
                      color: AppColors.starFilled, size: 32),
                  Icon(Icons.star_rounded,
                      color: AppColors.starFilled, size: 32),
                  Icon(Icons.star_rounded,
                      color: AppColors.starFilled, size: 32),
                ],
              )
                  .animate()
                  .scale(
                    begin: const Offset(0.0, 0.0),
                    end: const Offset(1.0, 1.0),
                    duration: 600.ms,
                    delay: 300.ms,
                    curve: Curves.elasticOut,
                  ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}