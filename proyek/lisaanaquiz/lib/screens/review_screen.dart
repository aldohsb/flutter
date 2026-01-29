import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/user_model.dart';
import '../models/word_model.dart';
import '../data/database_helper.dart';
import '../services/storage_service.dart';

class ReviewScreen extends StatefulWidget {
  final UserModel user;

  const ReviewScreen({super.key, required this.user});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  List<WordModel> _words = [];
  List<WordModel> _filteredWords = [];
  bool _isLoading = true;
  bool _showArabic = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadWords();
  }

  Future<void> _loadWords() async {
    final currentLevel = await StorageService.instance.getHighestUnlockedLevel(widget.user.id);
    final words = DatabaseHelper.instance.getCompletedWords(currentLevel);
    
    setState(() {
      _words = words;
      _filteredWords = words;
      _isLoading = false;
    });
  }

  void _filterWords(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredWords = _words;
      });
      return;
    }

    final filtered = _words.where((word) {
      final lowerQuery = query.toLowerCase();
      return word.arabic.contains(query) ||
          word.transliteration.toLowerCase().contains(lowerQuery) ||
          word.indonesian.toLowerCase().contains(lowerQuery);
    }).toList();

    setState(() {
      _filteredWords = filtered;
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
                            _filterWords('');
                          },
                        )
                      : null,
                ),
                onChanged: _filterWords,
              ),
            ),

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
                                _searchController.text.isEmpty
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