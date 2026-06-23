import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../providers/user_provider.dart';
import '../models/quiz_result_model.dart';
import '../utils/love_language_info.dart';
import '../utils/storage_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/love_language_card.dart';
import '../widgets/result_chart.dart';
import 'home_screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _saved = false;
  final Set<int> _expandedCards = {0}; // primary card dibuka default
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _autoSave();
  }

  Future<void> _autoSave() async {
    if (_saved || _isSaving) return;
    setState(() => _isSaving = true);
    final quiz = context.read<QuizProvider>();
    final user = context.read<UserProvider>().activeUser;
    if (user == null || quiz.lastResult == null) return;
    final storage = await StorageService.create();
    await quiz.saveResult(user.id, storage);
    if (mounted) setState(() => _saved = true);
    setState(() => _isSaving = false);
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final user = context.watch<UserProvider>().activeUser;
    final result = quiz.lastResult;

    if (result == null || user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final primaryLL = result.primaryLanguage;
    final primaryInfo = LoveLanguageInfo.of(primaryLL);
    final ranked = result.ranking;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ── Hero header ────────────────────────────────────
          SliverToBoxAdapter(
            child: _HeroHeader(
              primaryInfo: primaryInfo,
              userName: user.name,
              score: result.scores[primaryLL] ?? 0,
              total: quiz.totalQuestions,
            ),
          ),

          // ── Chart ──────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.divider),
                ),
                child: ResultChart(
                  scores: result.scores,
                  totalQuestions: quiz.totalQuestions,
                ),
              ).animate().fadeIn(duration: 500.ms, delay: 400.ms),
            ),
          ),

          // ── Ranking title ──────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              child: Text(
                'Ranking Love Language Kamu',
                style: AppTextStyles.headingMedium,
              ).animate().fadeIn(duration: 400.ms, delay: 500.ms),
            ),
          ),

          // ── Love language cards ────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final entry = ranked[index];
                  return LoveLanguageCard(
                    language: entry.key,
                    score: entry.value,
                    totalQuestions: quiz.totalQuestions,
                    rank: index + 1,
                    isExpanded: _expandedCards.contains(index),
                    onToggle: () => setState(() {
                      if (_expandedCards.contains(index)) {
                        _expandedCards.remove(index);
                      } else {
                        _expandedCards.add(index);
                      }
                    }),
                  );
                },
                childCount: ranked.length,
              ),
            ),
          ),

          // ── Action buttons ─────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _retakeQuiz(context),
                      icon: const Icon(Icons.refresh_rounded, size: 18),
                      label: const Text('Ulangi Quiz'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _goHome(context),
                      icon: const Icon(Icons.home_rounded, size: 18),
                      label: const Text('Kembali ke Beranda'),
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 400.ms, delay: 700.ms),
            ),
          ),
        ],
      ),
    );
  }

  void _retakeQuiz(BuildContext context) {
    context.read<QuizProvider>().resetQuiz();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const ResultScreen()),
    );
    // Reset dan balik ke quiz screen
    Navigator.of(context).pop();
  }

  void _goHome(BuildContext context) {
    context.read<QuizProvider>().resetQuiz();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (route) => false,
    );
  }
}

class _HeroHeader extends StatelessWidget {
  final LoveLanguageInfo primaryInfo;
  final String userName;
  final int score;
  final int total;

  const _HeroHeader({
    required this.primaryInfo,
    required this.userName,
    required this.score,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      padding: const EdgeInsets.fromLTRB(24, 56, 24, 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primaryInfo.color,
            primaryInfo.color.withAlpha(200),
            AppColors.accent.withAlpha(180),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Konfirmasi tersimpan
          Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: Colors.white70, size: 16),
              const SizedBox(width: 6),
              Text(
                'Hasil disimpan',
                style: AppTextStyles.caption.copyWith(color: Colors.white70),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Emoji besar
          Text(
            primaryInfo.language.emoji,
            style: const TextStyle(fontSize: 52),
          )
              .animate()
              .scale(
                begin: const Offset(0.5, 0.5),
                end: const Offset(1, 1),
                duration: 500.ms,
                curve: Curves.elasticOut,
              ),
          const SizedBox(height: 12),

          // Tagline
          Text(
            'Love Language Utama',
            style: AppTextStyles.caption.copyWith(
              color: Colors.white70,
              letterSpacing: 1.2,
            ),
          ).animate().fadeIn(duration: 400.ms, delay: 200.ms),
          const SizedBox(height: 6),

          Text(
            primaryInfo.title,
            style: AppTextStyles.display.copyWith(
              color: Colors.white,
              fontSize: 30,
            ),
          ).animate().fadeIn(duration: 400.ms, delay: 250.ms),

          const SizedBox(height: 4),

          Text(
            '"${primaryInfo.tagline}"',
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white70,
              fontStyle: FontStyle.italic,
            ),
          ).animate().fadeIn(duration: 400.ms, delay: 300.ms),

          const SizedBox(height: 20),

          // Skor chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(30),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$score',
                  style: AppTextStyles.numberLarge.copyWith(
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),
                Text(
                  ' / $total jawaban',
                  style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 400.ms, delay: 350.ms),

          const SizedBox(height: 16),

          Text(
            'Hai, $userName! Kamu sudah menyelesaikan semua pertanyaan.',
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
          ).animate().fadeIn(duration: 400.ms, delay: 400.ms),
        ],
      ),
    );
  }
}