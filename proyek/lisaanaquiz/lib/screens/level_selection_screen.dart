import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/user_model.dart';
import '../services/storage_service.dart';
import '../services/audio_service.dart';
import '../widgets/level_card.dart';
import 'quiz_screen.dart';

class LevelSelectionScreen extends StatefulWidget {
  final UserModel user;

  const LevelSelectionScreen({super.key, required this.user});

  @override
  State<LevelSelectionScreen> createState() => _LevelSelectionScreenState();
}

class _LevelSelectionScreenState extends State<LevelSelectionScreen> {
  int _highestUnlockedLevel = 1;
  bool _isLoading = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final highest = await StorageService.instance.getHighestUnlockedLevel(widget.user.id);
    setState(() {
      _highestUnlockedLevel = highest;
      _isLoading = false;
    });

    // Auto scroll to current level
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients || highest <= 1) return;

      // Must match the GridView's actual layout below.
      const crossAxisCount = 2;
      const childAspectRatio = 1.3;
      const crossAxisSpacing = 16.0;
      const mainAxisSpacing = 16.0;
      const gridPadding = 16.0;

      final screenWidth = MediaQuery.of(context).size.width;
      final availableWidth =
          screenWidth - (gridPadding * 2) - (crossAxisSpacing * (crossAxisCount - 1));
      final cardWidth = availableWidth / crossAxisCount;
      final cardHeight = cardWidth / childAspectRatio;
      final rowHeight = cardHeight + mainAxisSpacing;

      // Row (0-based) that contains the current/next level.
      final rowIndex = (highest - 1) ~/ crossAxisCount;

      // Scroll to one row above the target so it isn't flush against the top edge.
      final rawOffset = (rowIndex - 1).clamp(0, rowIndex) * rowHeight;
      final maxScroll = _scrollController.position.maxScrollExtent;
      final targetOffset = rawOffset.clamp(0.0, maxScroll);

      _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _startLevel(int levelNumber) async {
    await AudioService.instance.playClickSound();
    
    if (!mounted) return;
    
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => QuizScreen(
          user: widget.user,
          levelNumber: levelNumber,
        ),
      ),
    ).then((_) => _loadProgress());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Level'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: FutureBuilder<int>(
                future: StorageService.instance.getTotalStars(widget.user.id),
                builder: (context, snapshot) {
                  final stars = snapshot.data ?? 0;
                  return Row(
                    children: [
                      const Icon(Icons.star, color: AppTheme.starGold),
                      const SizedBox(width: 4),
                      Text(
                        stars.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textWhite,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: AppTheme.gardenDecoration,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  // Header Info
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: AppTheme.cardShadow,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _InfoChip(
                              icon: Icons.lock_open,
                              label: 'Level Terbuka',
                              value: _highestUnlockedLevel.toString(),
                              color: AppTheme.correctGreen,
                            ),
                            const _InfoChip(
                              icon: Icons.emoji_events,
                              label: 'Total Level',
                              value: '350',
                              color: AppTheme.primaryGreen,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        LinearProgressIndicator(
                          value: _highestUnlockedLevel / 350,
                          backgroundColor: AppTheme.paleGreen,
                          valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Progress: ${(_highestUnlockedLevel / 350 * 100).toStringAsFixed(1)}%',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.textLight,
                              ),
                        ),
                      ],
                    ),
                  ),

                  // Level Grid
                  Expanded(
                    child: GridView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.3,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: 350,
                      itemBuilder: (context, index) {
                        final levelNumber = index + 1;
                        final isUnlocked = levelNumber <= _highestUnlockedLevel;

                        return FutureBuilder(
                          future: StorageService.instance.getLevelProgress(
                            widget.user.id,
                            levelNumber,
                          ),
                          builder: (context, snapshot) {
                            final progress = snapshot.data;
                            
                            return LevelCard(
                              levelNumber: levelNumber,
                              isUnlocked: isUnlocked,
                              stars: progress?.stars ?? 0,
                              isPassed: progress?.isPassed ?? false,
                              onTap: isUnlocked ? () => _startLevel(levelNumber) : null,
                            );
                          },
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

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textLight,
              ),
        ),
      ],
    );
  }
}