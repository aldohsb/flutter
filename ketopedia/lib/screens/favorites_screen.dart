import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/food_provider.dart';
import '../providers/user_provider.dart';
import '../utils/constants.dart';
import '../widgets/food_card.dart';
import 'food_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final userProvider = context.read<UserProvider>();
    if (userProvider.user != null) {
      await context
          .read<FoodProvider>()
          .loadFavorites(userProvider.user!.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Makanan Favorit'),
      ),
      body: Consumer2<FoodProvider, UserProvider>(
        builder: (context, foodProvider, userProvider, child) {
          final favorites = foodProvider.favorites;

          if (favorites.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.paddingLarge),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 100,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Belum Ada Favorit',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap ikon ❤️ pada makanan untuk menambahkan ke favorit',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 24),
                    OutlinedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.search),
                      label: const Text('Cari Makanan'),
                    ),
                  ],
                ),
              ),
            );
          }

          return Column(
            children: [
              // Summary Card
              Container(
                margin: const EdgeInsets.all(AppConstants.paddingMedium),
                padding: const EdgeInsets.all(AppConstants.paddingMedium),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppConstants.primaryRed.withOpacity(0.1),
                      AppConstants.accentYellow.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(
                    AppConstants.radiusMedium,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: AppConstants.primaryRed,
                      size: 32,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${favorites.length} Makanan Favorit',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          Text(
                            'Makanan yang Anda sukai',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Favorites List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingMedium,
                  ),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final food = favorites[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: FoodCard(
                        food: food,
                        isFavorite: true,
                        onFavoriteTap: userProvider.user != null
                            ? () async {
                                await foodProvider.toggleFavorite(
                                  userProvider.user!.id!,
                                  food.id!,
                                );
                              }
                            : null,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FoodDetailScreen(food: food),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}