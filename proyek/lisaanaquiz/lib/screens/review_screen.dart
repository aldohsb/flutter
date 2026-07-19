import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/user_model.dart';
import '../models/word_model.dart';
import '../data/database_helper.dart';

class ReviewScreen extends StatefulWidget {
  final UserModel user;

  const ReviewScreen({super.key, required this.user});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _RankRange {
  final int start;
  final int end;

  const _RankRange(this.start, this.end);

  String get label => '$start-$end';

  bool contains(int rank) => rank >= start && rank <= end;
}

class _ReviewScreenState extends State<ReviewScreen> {
  List<WordModel> _words = [];
  List<WordModel> _filteredWords = [];
  List<_RankRange> _rankRanges = [];
  _RankRange? _selectedRange;
  bool _isLoading = true;
  bool _showArabic = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadWords();
  }

  Future<void> _loadWords() async {
    final words = DatabaseHelper.instance.getAllWords();

    setState(() {
      _words = words;
      _filteredWords = words;
      _rankRanges = _generateRankRanges(words);
      _isLoading = false;
    });
  }

  // Split the word list into fixed-size rank buckets (e.g. 100-299, 300-499, ...)
  // so the ranges always reflect whatever data is actually loaded.
  List<_RankRange> _generateRankRanges(List<WordModel> words) {
    if (words.isEmpty) return [];

    const step = 200;
    final ranks = words.map((w) => w.rank).toList();
    final minRank = ranks.reduce((a, b) => a < b ? a : b);
    final maxRank = ranks.reduce((a, b) => a > b ? a : b);

    final ranges = <_RankRange>[];
    var start = minRank;
    while (start <= maxRank) {
      ranges.add(_RankRange(start, start + step - 1));
      start += step;
    }
    return ranges;
  }

  void _selectRange(_RankRange? range) {
    setState(() {
      _selectedRange = _selectedRange == range ? null : range;
    });
    _applyFilters();
  }

  // Strip Arabic diacritics (harakat/tashkeel) so search works regardless of
  // whether the user types them or not.
  String _stripDiacritics(String input) {
    return input.replaceAll(RegExp(r'[\u0610-\u061A\u064B-\u065F\u0670\u06D6-\u06ED]'), '');
  }

  void _applyFilters() {
    Iterable<WordModel> result = _words;

    if (_selectedRange != null) {
      result = result.where((word) => _selectedRange!.contains(word.rank));
    }

    final trimmedQuery = _searchController.text.trim();
    if (trimmedQuery.isNotEmpty) {
      final lowerQuery = trimmedQuery.toLowerCase();
      final strippedQuery = _stripDiacritics(trimmedQuery);

      result = result.where((word) {
        return _stripDiacritics(word.arabic).contains(strippedQuery) ||
            word.transliteration.toLowerCase().contains(lowerQuery) ||
            word.indonesian.toLowerCase().contains(lowerQuery);
      });
    }

    setState(() {
      _filteredWords = result.toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Kata'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _showArabic = !_showArabic;
              });
            },
            icon: Icon(_showArabic ? Icons.translate : Icons.abc),
            tooltip: _showArabic ? 'Tampilkan Indonesia' : 'Tampilkan Arab',
          ),
        ],
      ),
      body: Container(
        decoration: AppTheme.gardenDecoration,
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Cari kata...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            _applyFilters();
                          },
                        )
                      : null,
                ),
                onChanged: (_) => _applyFilters(),
              ),
            ),

            // Rank Range Filter Chips
            if (_rankRanges.isNotEmpty)
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: const Text('Semua'),
                        selected: _selectedRange == null,
                        onSelected: (_) => _selectRange(null),
                        selectedColor: AppTheme.primaryGreen,
                        labelStyle: TextStyle(
                          color: _selectedRange == null ? AppTheme.textWhite : AppTheme.textDark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ..._rankRanges.map((range) {
                      final isSelected = _selectedRange == range;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(range.label),
                          selected: isSelected,
                          onSelected: (_) => _selectRange(range),
                          selectedColor: AppTheme.primaryGreen,
                          labelStyle: TextStyle(
                            color: isSelected ? AppTheme.textWhite : AppTheme.textDark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),

            const SizedBox(height: 8),

            // Stats
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatItem(
                    icon: Icons.book,
                    label: 'Total Kata',
                    value: _words.length.toString(),
                  ),
                  _StatItem(
                    icon: Icons.filter_list,
                    label: 'Ditampilkan',
                    value: _filteredWords.length.toString(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Word List
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _filteredWords.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 64,
                                color: AppTheme.textLight.withValues(alpha: 0.5),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _searchController.text.isEmpty && _selectedRange == null
                                    ? 'Belum ada kata yang dipelajari'
                                    : 'Tidak ada hasil',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: AppTheme.textLight,
                                    ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: _filteredWords.length,
                          itemBuilder: (context, index) {
                            final word = _filteredWords[index];
                            return _WordCard(
                              word: word,
                              showArabic: _showArabic,
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primaryGreen),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textLight,
                  ),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.primaryGreen,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}

class _WordCard extends StatefulWidget {
  final WordModel word;
  final bool showArabic;

  const _WordCard({
    required this.word,
    required this.showArabic,
  });

  @override
  State<_WordCard> createState() => _WordCardState();
}

class _WordCardState extends State<_WordCard> {
  bool _isFlipped = false;

  void _toggleFlip() {
    setState(() {
      _isFlipped = !_isFlipped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _toggleFlip,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppTheme.lightGreen.withValues(alpha: 0.3),
                width: 1.5,
              ),
              boxShadow: AppTheme.cardShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Main Content
                Row(
                  children: [
                    // Rank Badge
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: AppTheme.primaryGradient,
                      ),
                      child: Center(
                        child: Text(
                          '#${widget.word.rank}',
                          style: const TextStyle(
                            color: AppTheme.textWhite,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(width: 16),
                    
                    // Word Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Arabic or Indonesian based on toggle
                          Text(
                            widget.showArabic ? widget.word.arabic : widget.word.indonesian,
                            style: widget.showArabic
                                ? AppTheme.arabicTextStyle.copyWith(fontSize: 28)
                                : Theme.of(context).textTheme.titleLarge,
                          ),
                          
                          const SizedBox(height: 4),
                          
                          // Transliteration
                          Text(
                            widget.word.transliteration,
                            style: AppTheme.transliterationStyle,
                          ),
                        ],
                      ),
                    ),
                    
                    // Flip Indicator
                    Icon(
                      _isFlipped ? Icons.visibility : Icons.visibility_off,
                      color: AppTheme.primaryGreen,
                    ),
                  ],
                ),
                
                // Flipped Content
                if (_isFlipped) ...[
                  const Divider(height: 24),
                  Row(
                    children: [
                      const Icon(
                        Icons.translate,
                        color: AppTheme.primaryGreen,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.showArabic ? widget.word.indonesian : widget.word.arabic,
                          style: widget.showArabic
                              ? Theme.of(context).textTheme.titleMedium
                              : AppTheme.arabicTextStyle.copyWith(fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}