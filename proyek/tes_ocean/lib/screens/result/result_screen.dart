import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../data/personality_insights.dart';
import '../../models/ocean_trait.dart';
import '../../models/quiz_result.dart';
import '../../theme/app_colors.dart';
import '../../utils/score_interpreter.dart';
import '../../widgets/insights_section.dart';
import '../../widgets/ocean_radar_chart.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/trait_score_card.dart';
import '../home_screen.dart';

/// Menampilkan hasil satu sesi tes secara lengkap: radar chart ringkasan
/// lima trait, kartu detail per trait, narasi interpretasi, panduan karir,
/// tips self improvement, tips belajar efektif, serta keunggulan & kelemahan.
class ResultScreen extends ConsumerWidget {
  const ResultScreen({
    super.key,
    required this.result,
    this.isFreshResult = false,
  });

  final QuizResult result;

  /// Jika true, layar ini dibuka tepat setelah tes selesai dikerjakan
  /// sehingga tombol navigasi mengarah kembali ke beranda, bukan "kembali".
  final bool isFreshResult;

  Map<OceanTrait, double> get _scoreMap => {
        OceanTrait.openness: result.opennessScore,
        OceanTrait.conscientiousness: result.conscientiousnessScore,
        OceanTrait.extraversion: result.extraversionScore,
        OceanTrait.agreeableness: result.agreeablenessScore,
        OceanTrait.neuroticism: result.neuroticismScore,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateLabel = DateFormat('d MMMM yyyy, HH:mm', 'id_ID').format(
      result.completedAt,
    );

    final insights = PersonalityInsightsEngine.generate(_scoreMap);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !isFreshResult,
        title: const Text('Hasil Tes'),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            // ── Timestamp ─────────────────────────────────────────────
            Text(
              'Diselesaikan pada $dateLabel',
              style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
            ),
            const SizedBox(height: 16),

            // ── Radar chart ───────────────────────────────────────────
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: OceanRadarChart(scores: _scoreMap),
              ),
            ),
            const SizedBox(height: 24),

            // ── Rincian per trait ─────────────────────────────────────
            const _SectionHeader(
              icon: Icons.analytics_rounded,
              label: 'Rincian Per Trait',
              color: AppColors.primary,
            ),
            const SizedBox(height: 12),
            ..._buildTraitSections(),
            const SizedBox(height: 28),

            // ── Keunggulan & kelemahan ────────────────────────────────
            const _SectionHeader(
              icon: Icons.balance_rounded,
              label: 'Keunggulan & Kelemahan',
              color: Color(0xFF059669),
            ),
            const SizedBox(height: 12),
            InsightsSection(
              icon: Icons.star_rounded,
              title: 'Keunggulan Anda',
              subtitle: 'Kekuatan alami berdasarkan profil kepribadian',
              items: insights.strengths,
              accentColor: const Color(0xFF059669),
              initiallyExpanded: true,
            ),
            const SizedBox(height: 10),
            InsightsSection(
              icon: Icons.trending_down_rounded,
              title: 'Area yang Perlu Diperhatikan',
              subtitle: 'Titik buta yang umum pada profil kepribadian ini',
              items: insights.weaknesses,
              accentColor: const Color(0xFFD97706),
            ),
            const SizedBox(height: 28),

            // ── Panduan karir ─────────────────────────────────────────
            const _SectionHeader(
              icon: Icons.work_rounded,
              label: 'Panduan Karir',
              color: Color(0xFF7C3AED),
            ),
            const SizedBox(height: 12),
            InsightsSection(
              icon: Icons.business_center_rounded,
              title: 'Jalur Karir yang Cocok',
              subtitle: 'Bidang pekerjaan yang selaras dengan kepribadian Anda',
              items: insights.careerPaths,
              accentColor: const Color(0xFF7C3AED),
              initiallyExpanded: true,
            ),
            const SizedBox(height: 28),

            // ── Self improvement ──────────────────────────────────────
            const _SectionHeader(
              icon: Icons.self_improvement_rounded,
              label: 'Tips Self Improvement',
              color: Color(0xFF0891B2),
            ),
            const SizedBox(height: 12),
            InsightsSection(
              icon: Icons.rocket_launch_rounded,
              title: 'Langkah Pengembangan Diri',
              subtitle: 'Tindakan konkret untuk bertumbuh dari titik Anda saat ini',
              items: insights.selfImprovementTips,
              accentColor: const Color(0xFF0891B2),
              initiallyExpanded: true,
            ),
            const SizedBox(height: 28),

            // ── Tips belajar ──────────────────────────────────────────
            const _SectionHeader(
              icon: Icons.school_rounded,
              label: 'Tips Belajar Efektif',
              color: Color(0xFFDB2777),
            ),
            const SizedBox(height: 12),
            InsightsSection(
              icon: Icons.auto_stories_rounded,
              title: 'Strategi Belajar untuk Anda',
              subtitle: 'Metode belajar yang paling sesuai dengan gaya kognitif Anda',
              items: insights.learningTips,
              accentColor: const Color(0xFFDB2777),
              initiallyExpanded: true,
            ),
            const SizedBox(height: 28),

            // ── Tombol kembali (hanya saat fresh result) ──────────────
            if (isFreshResult)
              PrimaryButton(
                label: 'Kembali ke Beranda',
                icon: Icons.home_rounded,
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                    (route) => false,
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTraitSections() {
    final widgets = <Widget>[];

    for (final trait in OceanTrait.values) {
      final score = _scoreMap[trait]!;
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TraitScoreCard(trait: trait, score: score),
              Padding(
                padding: const EdgeInsets.only(left: 4, right: 4, top: 8),
                child: Text(
                  ScoreInterpreter.interpretation(trait, score),
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return widgets;
  }
}

/// Header kecil dengan ikon dan label untuk memisahkan tiap kelompok section.
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}