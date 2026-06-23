import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/ocean_trait.dart';
import '../providers/profile_provider.dart';
import '../providers/quiz_session_provider.dart';
import '../providers/result_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/trait_score_card.dart';
import 'history/history_screen.dart';
import 'profile/profile_selection_screen.dart';
import 'quiz/quiz_screen.dart';

/// Dashboard utama setelah pengguna memilih profil: menampilkan ringkasan
/// hasil tes terakhir (jika ada) dan jalan pintas untuk memulai tes baru
/// atau melihat riwayat lengkap.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _switchProfile(BuildContext context, WidgetRef ref) {
    ref.read(activeProfileIdProvider.notifier).clear();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const ProfileSelectionScreen()),
      (route) => false,
    );
  }

  void _startQuiz(BuildContext context, WidgetRef ref) {
    ref.read(quizSessionProvider.notifier).reset();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const QuizScreen()),
    );
  }

  void _openHistory(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const HistoryScreen()),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeProfile = ref.watch(activeProfileProvider);

    if (activeProfile == null) {
      return const ProfileSelectionScreen();
    }

    final history = ref.watch(userResultHistoryProvider(activeProfile.id));
    final latestResult = history.isEmpty ? null : history.first;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ProfileAvatar(
              name: activeProfile.name,
              color: Color(activeProfile.avatarColorValue),
              size: 36,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Halo,',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    activeProfile.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Ganti Profil',
            icon: const Icon(Icons.switch_account_outlined),
            onPressed: () => _switchProfile(context, ref),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            _StartQuizBanner(onStart: () => _startQuiz(context, ref)),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Hasil Tes Terakhir',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (history.isNotEmpty)
                  TextButton(
                    onPressed: () => _openHistory(context),
                    child: const Text('Lihat Semua'),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            if (latestResult == null)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Text(
                  'Anda belum memiliki hasil tes. Mulai tes pertama Anda '
                  'untuk melihat profil kepribadian OCEAN Anda di sini.',
                  style: TextStyle(color: AppColors.textSecondary, height: 1.5),
                ),
              )
            else
              Column(
                children: [
                  TraitScoreCard(
                    trait: OceanTrait.openness,
                    score: latestResult.opennessScore,
                  ),
                  const SizedBox(height: 12),
                  TraitScoreCard(
                    trait: OceanTrait.conscientiousness,
                    score: latestResult.conscientiousnessScore,
                  ),
                  const SizedBox(height: 12),
                  TraitScoreCard(
                    trait: OceanTrait.extraversion,
                    score: latestResult.extraversionScore,
                  ),
                  const SizedBox(height: 12),
                  TraitScoreCard(
                    trait: OceanTrait.agreeableness,
                    score: latestResult.agreeablenessScore,
                  ),
                  const SizedBox(height: 12),
                  TraitScoreCard(
                    trait: OceanTrait.neuroticism,
                    score: latestResult.neuroticismScore,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _StartQuizBanner extends StatelessWidget {
  const _StartQuizBanner({required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 28),
          const SizedBox(height: 14),
          const Text(
            'Kenali Kepribadian Anda',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '50 pertanyaan singkat berbasis model Big Five (OCEAN) untuk '
            'memetakan lima dimensi kepribadian Anda.',
            style: TextStyle(color: Colors.white70, height: 1.5, fontSize: 13.5),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary,
              ),
              onPressed: onStart,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_arrow_rounded, size: 22),
                  SizedBox(width: 8),
                  Text('Mulai Tes Baru'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
