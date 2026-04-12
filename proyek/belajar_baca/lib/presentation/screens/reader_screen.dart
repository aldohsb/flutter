import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../providers/lesson_provider.dart';
import '../widgets/card_widget.dart';
import '../widgets/navigation_arrows.dart';
import '../widgets/progress_indicator_widget.dart';

class ReaderScreen extends StatefulWidget {
  const ReaderScreen({super.key});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      value: 1.0,
    );

    _fadeAnim = Tween<double>(begin: 0.65, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _scaleAnim = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  void _animateTransition(VoidCallback action) {
    if (!mounted) return;
    _controller.value = 0.0;
    action();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LessonProvider>();
    final chapter = provider.currentChapter;
    final card = chapter.cards[provider.currentCardIndex];
    final gradientColors =
        AppColors.chapterGradients[chapter.gradientIndex % AppColors.chapterGradients.length];
    final hasPrev = provider.currentCardIndex > 0;
    final hasNext = provider.currentCardIndex < chapter.totalCards - 1;

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity == null) return;
          if (details.primaryVelocity! < -200 && hasNext) {
            _animateTransition(provider.nextCard);
          } else if (details.primaryVelocity! > 200 && hasPrev) {
            _animateTransition(provider.previousCard);
          }
        },
        child: Stack(
          children: [
            // ── Card Background ──────────────────────────────────────
            FadeTransition(
              opacity: _fadeAnim,
              child: ScaleTransition(
                scale: _scaleAnim,
                child: SyllableCardWidget(
                  card: card,
                  gradientColors: gradientColors,
                ),
              ),
            ),

            // ── Top Bar ──────────────────────────────────────────────
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12),
                  child: Row(
                    children: [
                      _BackButton(onTap: () => Navigator.of(context).pop()),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          chapter.title,
                          style: AppTextStyles.cardCounter(
                              Colors.white.withAlpha(220)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 120,
                        child: ProgressIndicatorWidget(
                          total: chapter.totalCards,
                          current: provider.currentCardIndex,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Navigation Arrows ────────────────────────────────────
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: NavigationArrows(
                  hasPrevious: hasPrev,
                  hasNext: hasNext,
                  onPrevious: () =>
                      _animateTransition(provider.previousCard),
                  onNext: () => _animateTransition(provider.nextCard),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  final VoidCallback onTap;
  const _BackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(51),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withAlpha(100),
            width: 1.5,
          ),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}