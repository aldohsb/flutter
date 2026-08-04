import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../services/tts_service.dart';
import '../../state/font_scale_provider.dart';
import '../../state/hijaiyah_level_provider.dart';
import '../../state/hijaiyah_page_progress_provider.dart';
import '../reading_drill/drill_progress_bar.dart';
import 'hijaiyah_letter_view.dart';

class HijaiyahDrillScreen extends ConsumerStatefulWidget {
  final int level;

  const HijaiyahDrillScreen({super.key, required this.level});

  @override
  ConsumerState<HijaiyahDrillScreen> createState() =>
      _HijaiyahDrillScreenState();
}

class _HijaiyahDrillScreenState extends ConsumerState<HijaiyahDrillScreen> {
  final _tts = TtsService();
  late final PageController _controller;
  late int _pageIndex;

  @override
  void initState() {
    super.initState();
    _pageIndex =
        ref.read(hijaiyahPageProgressProvider.notifier).pageFor(widget.level);
    _controller = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _pageIndex = index);
    ref.read(hijaiyahPageProgressProvider.notifier).setPage(widget.level, index);
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
      ref.read(hijaiyahPageProgressProvider.notifier).clearLevel(widget.level);
      context.pushReplacement('/hijaiyah-result/${widget.level}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = ref.watch(hijaiyahPagesProvider(widget.level));
    final fontScale = ref.watch(fontScaleProvider);
    final isLast = _pageIndex == pages.length - 1;

    return Scaffold(
      appBar: AppBar(title: Text('Hijaiyah Level ${widget.level}')),
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
                          final letters = pages[index].letters;
                          return Center(
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 32,
                              children: [
                                for (var i = 0; i < letters.length; i++)
                                  HijaiyahLetterView(
                                    letter: letters[i],
                                    colorIndex: i,
                                    onTap: () =>
                                        _tts.speak(letters[i].pronunciation),
                                  ),
                              ],
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
                onPressed: () {
                  final letters = pages[_pageIndex].letters;
                  for (final letter in letters) {
                    _tts.speak(letter.pronunciation);
                  }
                },
                icon: const Icon(Icons.volume_up_rounded),
                label: const Text('Dengar Semua'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}