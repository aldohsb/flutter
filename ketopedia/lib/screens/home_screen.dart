import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../providers/food_provider.dart';
import '../providers/weight_provider.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';
import '../widgets/stat_card.dart';
import '../widgets/food_card.dart';
import 'food_list_screen.dart';
import 'weight_tracking_screen.dart';
import 'education_keto_screen.dart';
import 'profile_screen.dart';
import 'food_detail_screen.dart';
import 'macro_calculator_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final userProvider = context.read<UserProvider>();
    final foodProvider = context.read<FoodProvider>();
    final weightProvider = context.read<WeightProvider>();

    if (userProvider.user != null) {
      await foodProvider.loadFoods();
      await foodProvider.loadFavorites(userProvider.user!.id!);
      await weightProvider.loadEntries(userProvider.user!.id!);
    }
  }

  List<Widget> get _pages => [
        const _HomePage(),
        const FoodListScreen(),
        const WeightTrackingScreen(),
        const EducationKetoScreen(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Makanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monitor_weight),
            label: 'Tracking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Edukasi',
          ),
        ],
      ),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatCards(context),
                  const SizedBox(height: 24),
                  _buildQuickActions(context),
                  const SizedBox(height: 24),
                  _buildRecommendedFoods(context),
                  const SizedBox(height: 24),
                  _buildMotivationalCard(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final user = userProvider.user;
        if (user == null) return const SliverToBoxAdapter();

        return SliverAppBar(
          expandedHeight: 180,
          floating: false,
          pinned: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              '${Helpers.getGreeting()}, ${user.name}',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                shadows: [
                  Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 3,
                    color: Colors.black45,
                  ),
                ],
              ),
            ),
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppConstants.primaryRed,
                    AppConstants.primaryRed.withOpacity(0.8),
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      'Hari ke-${user.daysOnDiet}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${Helpers.getProgressEmoji((user.currentWeight - user.targetWeight).abs() / (user.currentWeight - user.targetWeight).abs() * 100)} Keep Going!',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatCards(BuildContext context) {
    return Consumer2<UserProvider, WeightProvider>(
      builder: (context, userProvider, weightProvider, child) {
        final user = userProvider.user;
        if (user == null) return const SizedBox();

        // Get current weight from latest weight entry, or use user's initial weight
        final latestWeight = weightProvider.currentWeight ?? user.currentWeight;
        
        // Calculate weight lost from initial weight (first weight entry or user's start weight)
        final initialWeight = weightProvider.initialWeight ?? user.currentWeight;
        final weightLost = initialWeight - latestWeight;
        
        // Remaining weight to target
        final remaining = latestWeight - user.targetWeight;

        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: 'Berat Saat Ini',
                    value: Helpers.formatWeight(latestWeight),
                    icon: Icons.monitor_weight,
                    color: AppConstants.primaryRed,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    title: 'BMI',
                    value: Helpers.formatBMI(user.bmi),
                    subtitle: user.bmiCategory,
                    icon: Icons.analytics,
                    color: Helpers.getBMIColor(user.bmi),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: 'Turun',
                    value: weightLost > 0 
                        ? '${weightLost.toStringAsFixed(1)} kg' 
                        : '0.0 kg',
                    subtitle: weightLost > 0 ? '🔥 Keep going!' : 'Mulai tracking!',
                    icon: Icons.trending_down,
                    color: weightLost > 0 
                        ? AppConstants.ratingExcellent 
                        : Colors.grey,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    title: 'Sisa Target',
                    value: remaining > 0 
                        ? '${remaining.toStringAsFixed(1)} kg' 
                        : 'Target tercapai! 🎉',
                    icon: Icons.flag,
                    color: remaining > 0 
                        ? AppConstants.accentYellow 
                        : AppConstants.ratingExcellent,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                context,
                'Kalkulator Makro',
                Icons.calculate,
                AppConstants.primaryRed,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MacroCalculatorScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                context,
                'Favorit',
                Icons.favorite,
                AppConstants.accentYellow,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoritesScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendedFoods(BuildContext context) {
    return Consumer<FoodProvider>(
      builder: (context, foodProvider, child) {
        final recommended = foodProvider.getRecommendedFoods().take(3).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rekomendasi Makanan',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FoodListScreen(),
                      ),
                    );
                  },
                  child: const Text('Lihat Semua'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...recommended.map((food) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: FoodCard(
                    food: food,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FoodDetailScreen(food: food),
                        ),
                      );
                    },
                  ),
                )),
          ],
        );
      },
    );
  }

  Widget _buildMotivationalCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppConstants.accentYellow.withOpacity(0.2),
            AppConstants.primaryRed.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.emoji_events,
            size: 48,
            color: AppConstants.accentYellow,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tetap Semangat!',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Setiap hari adalah kesempatan baru untuk menjadi lebih sehat. Keep going! 💪',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}