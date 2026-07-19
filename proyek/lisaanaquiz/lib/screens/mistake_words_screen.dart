import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/user_model.dart';
import '../models/word_model.dart';
import '../data/database_helper.dart';
import '../services/storage_service.dart';

class MistakeWordsScreen extends StatefulWidget {
  final UserModel user;

  const MistakeWordsScreen({super.key, required this.user});

  @override
  State<MistakeWordsScreen> createState() => _MistakeWordsScreenState();
}

class _MistakeWordsScreenState extends State<MistakeWordsScreen> {
  List<WordModel> _words = [];
  bool _isLoading = true;
  bool _showArabic = true;

  @override
  void initState() {
    super.initState();
    _loadWords();
  }

  Future<void> _loadWords() async {
    setState(() {
      _isLoading = true;
    });

    final ids = await StorageService.instance.getWrongWordIds(widget.user.id);
    final words = DatabaseHelper.instance.getWordsByIds(ids);

    setState(() {
      _words = words;
      _isLoading = false;
    });
  }

  Future<void> _removeWord(WordModel word) async {
    await StorageService.instance.removeWrongWord(widget.user.id, word.id);
    setState(() {
      _words.removeWhere((w) => w.id == word.id);
    });
  }

  Future<void> _confirmClearAll() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bersihkan Semua?'),
        content: const Text('Semua kata dalam daftar ini akan dihapus.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppTheme.wrongRed),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await StorageService.instance.clearWrongWords(widget.user.id);
      setState(() {
        _words = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kata Perlu Diulang'),
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
          if (_words.isNotEmpty)
            IconButton(
              onPressed: _confirmClearAll,
              icon: const Icon(Icons.delete_sweep_outlined),
              tooltip: 'Bersihkan Semua',
            ),
        ],
      ),
      body: Container(
        decoration: AppTheme.gardenDecoration,
        child: Column(
          children: [
            // Info banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.wrongRed.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: AppTheme.wrongRed),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Kata yang pernah salah kamu jawab di kuis. Jawab benar lagi di kuis untuk menghapusnya dari daftar ini.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.textDark,
                          ),
                    ),
                  ),
                ],
              ),
            ),

            // Word List
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _words.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.celebration_outlined,
                                size: 64,
                                color: AppTheme.textLight.withValues(alpha: 0.5),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Belum ada kata yang salah.\nTerus semangat belajar!',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: AppTheme.textLight,
                                    ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: _words.length,
                          itemBuilder: (context, index) {
                            final word = _words[index];
                            return _MistakeWordCard(
                              word: word,
                              showArabic: _showArabic,
                              onRemove: () => _removeWord(word),
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

class _MistakeWordCard extends StatefulWidget {
  final WordModel word;
  final bool showArabic;
  final VoidCallback onRemove;

  const _MistakeWordCard({
    required this.word,
    required this.showArabic,
    required this.onRemove,
  });

  @override
  State<_MistakeWordCard> createState() => _MistakeWordCardState();
}

class _MistakeWordCardState extends State<_MistakeWordCard> {
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
                color: AppTheme.wrongRed.withValues(alpha: 0.3),
                width: 1.5,
              ),
              boxShadow: AppTheme.cardShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    // Rank Badge
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.wrongRed,
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
                          Text(
                            widget.showArabic ? widget.word.arabic : widget.word.indonesian,
                            style: widget.showArabic
                                ? AppTheme.arabicTextStyle.copyWith(fontSize: 28)
                                : Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.word.transliteration,
                            style: AppTheme.transliterationStyle,
                          ),
                        ],
                      ),
                    ),

                    // Remove button
                    IconButton(
                      onPressed: widget.onRemove,
                      icon: const Icon(Icons.close, color: AppTheme.textLight),
                      tooltip: 'Hapus dari daftar',
                    ),
                  ],
                ),

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