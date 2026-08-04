import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_colors.dart';
import 'app_constants.dart';
import 'app_theme.dart';
import 'character_item.dart';
import 'gradient_scaffold_background.dart';
import 'hiragana_data.dart';
import 'kanji_data.dart';
import 'katakana_data.dart';
import 'mistake_service.dart';
import 'quiz_category.dart';
import 'section_header.dart';

/// Menampilkan daftar lengkap aksara pada satu kategori sebagai referensi
/// belajar (bukan kuis) - bisa dicari, dan aksara yang sering dijawab
/// salah diberi penanda angka merah di pojok kartu.
class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key, required this.category});

  final QuizCategory category;

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _onlyMistakes = false;
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<CharacterItem> get _fullList {
    switch (widget.category) {
      case QuizCategory.hiragana:
        return kHiraganaData;
      case QuizCategory.katakana:
        return kKatakanaData;
      case QuizCategory.kanji:
        return kKanjiData;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mistakeService = context.watch<MistakeService>();
    final query = _query.trim().toLowerCase();

    var items = _fullList.where((item) {
      if (query.isEmpty) return true;
      return item.character.contains(query) || item.romaji.toLowerCase().contains(query);
    }).toList();

    if (_onlyMistakes) {
      items = items.where((item) {
        final stat = mistakeService.statFor(widget.category, item.character);
        return stat != null && stat.wrongCount > 0;
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(title: Text('Daftar ${widget.category.displayName}')),
      body: GradientScaffoldBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SectionHeader(
                  title: 'Daftar Aksara',
                  subtitle: '${_fullList.length} aksara ${widget.category.displayName} • referensi belajar',
                ),
                const SizedBox(height: AppSpacing.md),
                TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => _query = value),
                  decoration: InputDecoration(
                    hintText: 'Cari aksara atau bacaan latin...',
                    prefixIcon: const Icon(Icons.search_rounded),
                    filled: true,
                    fillColor: AppColors.sandSurface,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      borderSide: BorderSide(color: AppColors.stone.withValues(alpha: 0.6)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      borderSide: BorderSide(color: AppColors.stone.withValues(alpha: 0.6)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      borderSide: const BorderSide(color: AppColors.sage, width: 1.6),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Align(
                  alignment: Alignment.centerLeft,
                  child: FilterChip(
                    label: const Text('Hanya yang sering salah'),
                    selected: _onlyMistakes,
                    onSelected: (value) => setState(() => _onlyMistakes = value),
                    backgroundColor: AppColors.sandSurface,
                    selectedColor: AppColors.clay.withValues(alpha: 0.18),
                    checkmarkColor: AppColors.clayDark,
                    side: BorderSide(color: AppColors.stone.withValues(alpha: 0.6)),
                    labelStyle: TextStyle(
                      color: _onlyMistakes ? AppColors.clayDark : AppColors.inkSoft,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.5,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Expanded(
                  child: items.isEmpty
                      ? Center(
                          child: Text(
                            _onlyMistakes
                                ? 'Belum ada aksara yang sering salah di sini.'
                                : 'Aksara tidak ditemukan.',
                            style: const TextStyle(color: AppColors.inkFaint),
                          ),
                        )
                      : GridView.builder(
                          itemCount: items.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: widget.category == QuizCategory.kanji ? 3 : 4,
                            crossAxisSpacing: AppSpacing.sm,
                            mainAxisSpacing: AppSpacing.sm,
                            childAspectRatio: widget.category == QuizCategory.kanji ? 0.78 : 0.85,
                          ),
                          itemBuilder: (context, index) {
                            final item = items[index];
                            final stat = mistakeService.statFor(widget.category, item.character);
                            return _CharacterCard(
                              item: item,
                              wrongCount: stat?.wrongCount ?? 0,
                              showMeaning: widget.category == QuizCategory.kanji,
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CharacterCard extends StatelessWidget {
  const _CharacterCard({
    required this.item,
    required this.wrongCount,
    required this.showMeaning,
  });

  final CharacterItem item;
  final int wrongCount;
  final bool showMeaning;

  @override
  Widget build(BuildContext context) {
    final meaning = item.meaningId;

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: AppColors.sandSurface,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.stone.withValues(alpha: 0.6)),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.character,
                style: AppTheme.jpTextStyle(fontSize: 26, color: AppColors.sageDeep),
              ),
              const SizedBox(height: 4),
              Text(
                item.romaji,
                style: const TextStyle(fontSize: 11.5, color: AppColors.inkSoft, fontWeight: FontWeight.w600),
              ),
              if (showMeaning && meaning != null) ...[
                const SizedBox(height: 2),
                Text(
                  meaning,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 10, color: AppColors.inkFaint, fontStyle: FontStyle.italic),
                ),
              ],
            ],
          ),
        ),
        if (wrongCount > 0)
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.error,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$wrongCount',
                style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
          ),
      ],
    );
  }
}