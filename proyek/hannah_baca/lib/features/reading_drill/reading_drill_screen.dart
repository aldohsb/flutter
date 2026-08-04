import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/color_mode.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../services/tts_service.dart';
import '../../state/font_scale_provider.dart';
import '../../state/level_provider.dart';
import '../../state/page_progress_provider.dart';
import '../../state/settings_provider.dart';
import 'drill_progress_bar.dart';
import 'syllable_word.dart';

class ReadingDrillScreen extends ConsumerStatefulWidget {
  final int level;

  const ReadingDrillScreen({super.key, required this.level});

  @override
  ConsumerState<ReadingDrillScreen> createState() =>
      _ReadingDrillScreenState();
}

class _ReadingDrillScreenState extends ConsumerState<ReadingDrillScreen> {
  final _tts = TtsService();
  late final PageController _controller;
  late int _pageIndex;

  @override
  void initState() {
    super.initState();
    _pageIndex = ref.read(pageProgressProvider.notifier).pageFor(widget.level);
    _controller = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _pageIndex = index);
    ref.read(pageProgressProvider.notifier).setPage(widget.level, index);
  }

  void _goPrev() {
    _controller.previousPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  void _goNextOrFinish(int totalPages) {
    if (_pageIndex < totalPages - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    } else {
      ref.read(pageProgressProvider.notifier).clearLevel(widget.level);
      context.pushReplacement('/result/${widget.level}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = ref.watch(levelPagesProvider(widget.level));
    final colorMode = ref.watch(colorModeProvider);
    final fontScale = ref.watch(fontScaleProvider);
    final isLast = _pageIndex == pages.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Level ${widget.level}'),
        actions: [
          IconButton(
            tooltip: 'Ganti warna suku kata',
            onPressed: () => ref.read(colorModeProvider.notifier).toggle(),
            icon: Icon(
              colorMode == SyllableColorMode.multi
                  ? Icons.palette_rounded
                  : Icons.format_color_text_rounded,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              DrillProgressBar(currentPage: _pageIndex, totalPages: pages.length),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    tooltip: 'Perkecil huruf',
                    onPressed: () => ref.read(fontScaleProvider.notifier).decrease(),
                    icon: const Icon(Icons.zoom_out_rounded),
                    color: AppColors.textDark,
                  ),
                  Text('${(fontScale * 100).round()}%', style: AppTextStyles.body),
                  IconButton(
                    tooltip: 'Perbesar huruf',
                    onPressed: () => ref.read(fontScaleProvider.notifier).increase(),
                    icon: const Icon(Icons.zoom_in_rounded),
                    color: AppColors.textDark,
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: _pageIndex == 0 ? null : _goPrev,
                      icon: const Icon(Icons.chevron_left_rounded, size: 40),
                      color: AppColors.primary,
                    ),
                    Expanded(
                      child: PageView.builder(
                        controller: _controller,
                        onPageChanged: _onPageChanged,
                        itemCount: pages.length,
                        itemBuilder: (context, index) {
                          final word = pages[index].words.first;
                          return Center(
                            child: GestureDetector(
                              onTap: () => _tts.speak(word.word),
                              child: SyllableWord(entry: word),
                            ),
                          );
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () => _goNextOrFinish(pages.length),
                      icon: Icon(
                        isLast
                            ? Icons.check_circle_rounded
                            : Icons.chevron_right_rounded,
                        size: 40,
                      ),
                      color: AppColors.secondary,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () => _tts.speak(pages[_pageIndex].words.first.word),
                icon: const Icon(Icons.volume_up_rounded),
                label: const Text('Dengar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}