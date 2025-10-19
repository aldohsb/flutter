import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/user_model.dart';
import '../services/storage_service.dart';
import '../services/audio_service.dart';
import 'level_selection_screen.dart';
import 'review_screen.dart';
import 'user_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  final UserModel user;

  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  int _totalStars = 0;
  int _completedLevels = 0;
  int _highestLevel = 1;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _loadUserStats();
    _animController.forward();
  }

  Future<void> _loadUserStats() async {
    final stars = await StorageService.instance.getTotalStars(widget.user.id);
    final completed = await StorageService.instance.getCompletedLevels(widget.user.id);
    final highest = await StorageService.instance.getHighestUnlockedLevel(widget.user.id);
    
    setState(() {
      _totalStars = stars;
      _completedLevels = completed;
      _highestLevel = highest;
      _isLoading = false;
    });
  }

  Future<void> _showSettings() async {
    await AudioService.instance.playClickSound();
    
    if (!mounted) return;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Pengaturan',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            
            // Sound Toggle
            FutureBuilder<bool>(
              future: StorageService.instance.isSoundEnabled(),
              builder: (context, snapshot) {
                final soundEnabled = snapshot.data ?? true;
                return SwitchListTile(
                  title: const Text('Efek Suara'),
                  subtitle: const Text('Aktifkan sound effect'),
                  value: soundEnabled,
                  activeTrackColor: AppTheme.primaryGreen,
                  onChanged: (value) async {
                    await StorageService.instance.setSoundEnabled(value);
                    setState(() {});
                  },
                );
              },
            ),
            
            const Divider(),
            
            // Switch User
            ListTile(
              leading: const Icon(Icons.switch_account, color: AppTheme.primaryGreen),
              title: const Text('Ganti Pengguna'),
              onTap: () async {
                Navigator.pop(context);
                await AudioService.instance.playClickSound();
                if (!context.mounted) return;
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const UserSelectionScreen()),
                );
              },
            ),
            
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.gardenDecoration,
        child: SafeArea(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'السَّلاَمُ عَلَيْكُمْ',
                                  style: AppTheme.arabicTextStyle.copyWith(
                                    fontSize: 24,
                                    color: AppTheme.primaryGreen,
                                  ),
                                ),
                                Text(
                                  widget.user.username,
                                  style: Theme.of(context).textTheme.headlineMedium,
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: _showSettings,
                              icon: const Icon(Icons.settings, size: 28),
                              color: AppTheme.primaryGreen,
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 32),
                        
                        // Stats Cards
                        Row(
                          children: [
                            Expanded(
                              child: _StatCard(
                                icon: Icons.star,
                                label: 'Total Bintang',
                                value: _totalStars.toString(),
                                color: AppTheme.starGold,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _StatCard(
                                icon: Icons.check_circle,
                                label: 'Level Selesai',
                                value: _completedLevels.toString(),
                                color: AppTheme.correctGreen,
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 32),
                        
                        // Main Menu Card
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: AppTheme.arabianCardDecoration,
                          child: Column(
                            children: [
                              // Logo
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: AppTheme.primaryGradient,
                                  boxShadow: AppTheme.cardShadow,
                                ),
                                child: const Icon(
                                  Icons.menu_book_rounded,
                                  size: 50,
                                  color: AppTheme.textWhite,
                                ),
                              ),
                              
                              const SizedBox(height: 24),
                              
                              Text(
                                'لِسَانَ عَرَبِيَّة',
                                style: AppTheme.arabicTextStyle.copyWith(
                                  fontSize: 32,
                                  color: AppTheme.primaryGreen,
                                ),
                              ),
                              
                              const SizedBox(height: 8),
                              
                              Text(
                                'Belajar 1700+ Kosakata Arab Populer',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppTheme.textLight,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              
                              const SizedBox(height: 32),
                              
                              // Start Quiz Button
                              ElevatedButton(
                                onPressed: () async {
                                  await AudioService.instance.playClickSound();
                                  if (!context.mounted) return;
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => LevelSelectionScreen(user: widget.user),
                                    ),
                                  ).then((_) => _loadUserStats());
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 56),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.play_arrow),
                                    const SizedBox(width: 8),
                                    Text('Mulai Kuis - Level $_highestLevel'),
                                  ],
                                ),
                              ),
                              
                              const SizedBox(height: 16),
                              
                              // Review Button
                              OutlinedButton(
                                onPressed: () async {
                                  await AudioService.instance.playClickSound();
                                  if (!context.mounted) return;
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => ReviewScreen(user: widget.user),
                                    ),
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 56),
                                  side: const BorderSide(
                                    color: AppTheme.primaryGreen,
                                    width: 2,
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.replay),
                                    SizedBox(width: 8),
                                    Text('Review Kata'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 32),
                        
                        // Progress Info
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppTheme.primaryGreen.withValues(alpha: 0.3),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.info_outline,
                                    color: AppTheme.primaryGreen,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Progress Belajar',
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              _ProgressItem(
                                label: 'Level Tertinggi',
                                value: 'Level $_highestLevel dari 350',
                              ),
                              const SizedBox(height: 8),
                              _ProgressItem(
                                label: 'Kata Dikuasai',
                                value: '${_completedLevels * 10} kata',
                              ),
                              const SizedBox(height: 8),
                              _ProgressItem(
                                label: 'Persentase',
                                value: '${(_completedLevels / 350 * 100).toStringAsFixed(1)}%',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 12),
          Text(
            value,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.textLight,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ProgressItem extends StatelessWidget {
  final String label;
  final String value;

  const _ProgressItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryGreen,
          ),
        ),
      ],
    );
  }
}