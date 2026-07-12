import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:confetti/confetti.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../state/progress_provider.dart';

class LevelResultScreen extends ConsumerStatefulWidget {
  final int level;

  const LevelResultScreen({super.key, required this.level});

  @override
  ConsumerState<LevelResultScreen> createState() => _LevelResultScreenState();
}

class _LevelResultScreenState extends ConsumerState<LevelResultScreen> {
  late final ConfettiController _confetti;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 2));
    _confetti.play();
    Future.microtask(
      () => ref.read(progressProvider.notifier).completeLevel(widget.level),
    );
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasNext = widget.level < AppConstants.totalLevels;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.emoji_events_rounded,
                        size: 100, color: AppColors.accent),
                    const SizedBox(height: 16),
                    Text('Level ${widget.level} Selesai!',
                        style: AppTextStyles.title),
                    const SizedBox(height: 32),
                    if (hasNext)
                      ElevatedButton(
                        onPressed: () => context.pushReplacement(
                          '/drill/${widget.level + 1}',
                        ),
                        child: const Text('Level Berikutnya'),
                      ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () => context.go('/levels'),
                      child: const Text('Kembali ke Peta Level'),
                    ),
                  ],
                ),
              ),
            ),
            ConfettiWidget(
              confettiController: _confetti,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: AppColors.syllablePalette,
            ),
          ],
        ),
      ),
    );
  }
}