import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/profile_provider.dart';
import '../../providers/quiz_session_provider.dart';
import '../../theme/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../widgets/likert_selector.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/quiz_progress_bar.dart';
import '../result/result_screen.dart';

/// Halaman utama pengerjaan tes: diawali halaman intro berisi instruksi
/// kejujuran, lalu menampilkan satu pertanyaan pada satu waktu beserta
/// progress bar dan navigasi maju/mundur antar pertanyaan.
class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({super.key});

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  /// Saat [_showIntro] true, layar menampilkan halaman instruksi.
  /// Setelah pengguna menekan "Mulai", nilai berubah ke false dan
  /// quiz dimulai dari soal pertama.
  bool _showIntro = true;

  Future<bool> _confirmExit() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Keluar dari tes?'),
        content: const Text(
          'Progres jawaban Anda saat ini akan hilang jika keluar sekarang.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Lanjutkan Tes'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Keluar', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  Future<void> _handleNext() async {
    final notifier = ref.read(quizSessionProvider.notifier);
    final session = ref.read(quizSessionProvider);

    if (!session.isLastQuestion) {
      notifier.goToNext();
      return;
    }

    final activeProfile = ref.read(activeProfileProvider);
    if (activeProfile == null) return;

    final result = await notifier.finishAndSave(activeProfile.id);

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ResultScreen(result: result, isFreshResult: true),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        if (_showIntro) {
          Navigator.of(context).pop();
          return;
        }
        final shouldExit = await _confirmExit();
        if (shouldExit && mounted) Navigator.of(context).pop();
      },
      child: _showIntro ? _buildIntroPage() : _buildQuizPage(),
    );
  }

  // ── Halaman intro instruksi ──────────────────────────────────────────────
  Widget _buildIntroPage() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Sebelum Mulai'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),

                      // Ikon & judul
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.psychology_rounded,
                          color: AppColors.primary,
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Panduan Mengerjakan Tes',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Instruksi utama
                      const _IntroCard(
                        icon: Icons.person_rounded,
                        color: AppColors.primary,
                        title: 'Jawab sebagai diri Anda yang sebenarnya',
                        body: AppConstants.introInstructions,
                      ),
                      const SizedBox(height: 12),

                      // Peringatan netral
                      const _IntroCard(
                        icon: Icons.warning_amber_rounded,
                        color: Color(0xFFD97706),
                        title: 'Hindari terlalu sering memilih "Netral"',
                        body: 'Pilihan "Netral / Tergantung Situasi" tersedia '
                            'untuk kondisi yang benar-benar tidak dapat Anda '
                            'tentukan arahnya. Jika Anda cenderung ke salah '
                            'satu sisi — sekecil apapun — pilihlah "Agak '
                            'Setuju" atau "Agak Tidak Setuju".\n\n'
                            'Terlalu banyak jawaban netral akan membuat hasil '
                            'tes Anda kurang informatif dan tidak mencerminkan '
                            'kepribadian Anda secara akurat.',
                      ),
                      const SizedBox(height: 12),

                      // Skala jawaban
                      const _IntroCard(
                        icon: Icons.tune_rounded,
                        color: Color(0xFF059669),
                        title: '7 tingkat jawaban tersedia',
                        body: 'Skala jawaban dari 1 hingga 7:\n\n'
                            '1 — Sangat Tidak Setuju\n'
                            '2 — Tidak Setuju\n'
                            '3 — Agak Tidak Setuju\n'
                            '4 — Netral / Tergantung Situasi\n'
                            '5 — Agak Setuju\n'
                            '6 — Setuju\n'
                            '7 — Sangat Setuju\n\n'
                            'Gradasi ini membantu menghasilkan profil '
                            'kepribadian yang lebih akurat dan personal.',
                      ),
                      const SizedBox(height: 12),

                      // Info waktu
                      const _IntroCard(
                        icon: Icons.timer_outlined,
                        color: AppColors.textSecondary,
                        title: '50 pertanyaan · ±10–15 menit',
                        body: 'Tidak ada batas waktu. Kerjakan dengan santai '
                            'dan penuh refleksi. Anda dapat kembali ke '
                            'pertanyaan sebelumnya kapan saja.',
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // Tombol mulai
              Padding(
                padding: const EdgeInsets.only(bottom: 24, top: 8),
                child: PrimaryButton(
                  label: 'Saya Siap, Mulai Tes',
                  icon: Icons.play_arrow_rounded,
                  onPressed: () => setState(() => _showIntro = false),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Halaman soal ─────────────────────────────────────────────────────────
  Widget _buildQuizPage() {
    final session = ref.watch(quizSessionProvider);
    final question = session.currentQuestion;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () async {
            final shouldExit = await _confirmExit();
            if (shouldExit && mounted) Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              QuizProgressBar(
                currentIndex: session.currentIndex,
                totalQuestions: session.totalQuestions,
                progress: session.progress,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),

                      // Pengingat kejujuran (hanya soal pertama)
                      if (session.currentIndex == 0) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.2),
                            ),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.lightbulb_outline_rounded,
                                size: 16,
                                color: AppColors.primary,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  AppConstants.honestInstruction,
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    color: AppColors.primary,
                                    height: 1.45,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],

                      Text(
                        question.text,
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 28),
                      LikertSelector(
                        selectedValue: session.currentAnswer,
                        onChanged: (value) {
                          ref
                              .read(quizSessionProvider.notifier)
                              .selectAnswer(value);
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24, top: 8),
                child: Row(
                  children: [
                    if (!session.isFirstQuestion)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            ref
                                .read(quizSessionProvider.notifier)
                                .goToPrevious();
                          },
                          child: const Text('Kembali'),
                        ),
                      ),
                    if (!session.isFirstQuestion) const SizedBox(width: 14),
                    Expanded(
                      flex: 2,
                      child: PrimaryButton(
                        label: session.isLastQuestion ? 'Selesai' : 'Lanjut',
                        icon: session.isLastQuestion
                            ? Icons.check_rounded
                            : Icons.arrow_forward_rounded,
                        onPressed: session.canGoNext ? _handleNext : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Widget kartu instruksi ────────────────────────────────────────────────
class _IntroCard extends StatelessWidget {
  const _IntroCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 17),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            body,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}