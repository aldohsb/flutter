import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../services/tts_service.dart';
import '../../state/level_provider.dart';
import '../../state/page_progress_provider.dart';
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
  late int _pageIndex;

  @override
  void initState() {
    super.initState();
    _pageIndex = ref.read(pageProgressProvider.notifier).pageFor(widget.level);
  }

  void _goTo(int index, int totalPages) {
    setState(() => _pageIndex = index);
    ref.read(pageProgressProvider.notifier).setPage(widget.level, index);
  }

  void _next(int totalPages) {
    if (_pageIndex < totalPages - 1) {
      _goTo(_pageIndex + 1, totalPages);
    } else {
      ref.read(pageProgressProvider.notifier).clearLevel(widget.level);
      context.pushReplacement('/result/${widget.level}');
    }
  }

  void _prev() {
    if (_pageIndex > 0) _goTo(_pageIndex - 1, 0);
  }

  @override
  Widget build(BuildContext context) {
    final pages = ref.watch(levelPagesProvider(widget.level));
    final safeIndex = _pageIndex.clamp(0, pages.length - 1);
    final page = pages[safeIndex];

    return Scaffold(
      appBar: AppBar(title: Text('Level ${widget.level}')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              DrillProgressBar(currentPage: safeIndex, totalPages: pages.length),
              const SizedBox(height: 24),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (final entry in page.words)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: GestureDetector(
                              onTap: () => _tts.speak(entry.word),
                              child: SyllableWord(entry: entry),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: safeIndex == 0 ? null : _prev,
                    icon: const Icon(Icons.arrow_back_ios_rounded),
                    color: AppColors.primary,
                  ),
                  ElevatedButton(
                    onPressed: () => _next(pages.length),
                    child: Text(
                        safeIndex == pages.length - 1 ? 'Selesai' : 'Lanjut'),
                  ),
                  IconButton(
                    onPressed: () => _tts.speak(
                      page.words.map((w) => w.word).join(', '),
                    ),
                    icon: const Icon(Icons.volume_up_rounded),
                    color: AppColors.secondary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}