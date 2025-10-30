import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/food_provider.dart';
import '../providers/user_provider.dart';
import '../utils/constants.dart';
import '../widgets/food_card.dart';
import '../widgets/rating_badge.dart';
import 'food_detail_screen.dart';

class FoodListScreen extends StatefulWidget {
  const FoodListScreen({super.key});

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Database Makanan'),
            pinned: true,
            floating: true,
            actions: [
              PopupMenuButton<String>(
                icon: const Icon(Icons.info_outline),
                onSelected: (_) => _showRatingLegend(),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'legend',
                    child: Text('Lihat Panduan Rating'),
                  ),
                ],
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Column(
                children: [
                  _buildSearchBar(),
                  const SizedBox(height: 12),
                  _buildCategoryFilter(),
                  const SizedBox(height: 12),
                  _buildRatingFilter(),
                ],
              ),
            ),
          ),
          _buildFoodList(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Consumer<FoodProvider>(
      builder: (context, foodProvider, child) {
        return TextField(
          decoration: InputDecoration(
            hintText: 'Cari makanan...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: foodProvider.searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      foodProvider.searchFoods('');
                      // Clear the text field
                      FocusScope.of(context).unfocus();
                    },
                  )
                : null,
          ),
          onChanged: (value) {
            foodProvider.searchFoods(value);
          },
        );
      },
    );
  }

  Widget _buildCategoryFilter() {
    return Consumer<FoodProvider>(
      builder: (context, foodProvider, child) {
        return SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildFilterChip(
                label: 'Semua',
                isSelected: foodProvider.selectedCategory == null,
                onTap: () => foodProvider.filterByCategory(null),
              ),
              ...FoodCategory.values.map((category) => _buildFilterChip(
                    label: category.displayName,
                    isSelected: foodProvider.selectedCategory == category,
                    onTap: () => foodProvider.filterByCategory(category),
                  )),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRatingFilter() {
    return Consumer<FoodProvider>(
      builder: (context, foodProvider, child) {
        return SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildRatingFilterChip(
                rating: null,
                label: 'Semua Rating',
                isSelected: foodProvider.selectedRating == null,
              ),
              _buildRatingFilterChip(
                rating: AppConstants.ratingExcellentValue,
                label: 'Sangat Dianjurkan',
                isSelected: foodProvider.selectedRating == AppConstants.ratingExcellentValue,
              ),
              _buildRatingFilterChip(
                rating: AppConstants.ratingModerateValue,
                label: 'Moderat',
                isSelected: foodProvider.selectedRating == AppConstants.ratingModerateValue,
              ),
              _buildRatingFilterChip(
                rating: AppConstants.ratingCarefulValue,
                label: 'Hati-hati',
                isSelected: foodProvider.selectedRating == AppConstants.ratingCarefulValue,
              ),
              _buildRatingFilterChip(
                rating: AppConstants.ratingAvoidValue,
                label: 'Hindari',
                isSelected: foodProvider.selectedRating == AppConstants.ratingAvoidValue,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onTap(),
        backgroundColor: Theme.of(context).cardColor,
        selectedColor: AppConstants.primaryRed.withOpacity(0.2),
        checkmarkColor: AppConstants.primaryRed,
      ),
    );
  }

  Widget _buildRatingFilterChip({
    required int? rating,
    required String label,
    required bool isSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => context.read<FoodProvider>().filterByRating(rating),
        backgroundColor: Theme.of(context).cardColor,
        selectedColor: AppConstants.primaryRed.withOpacity(0.2),
        checkmarkColor: AppConstants.primaryRed,
      ),
    );
  }

  Widget _buildFoodList() {
    return Consumer2<FoodProvider, UserProvider>(
      builder: (context, foodProvider, userProvider, child) {
        if (foodProvider.isLoading) {
          return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final foods = foodProvider.foods;

        if (foods.isEmpty) {
          return const SliverFillRemaining(
            child: Center(
              child: Text('Tidak ada makanan yang ditemukan'),
            ),
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final food = foods[index];
                final isFavorite = foodProvider.favorites
                    .any((fav) => fav.id == food.id);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: FoodCard(
                    food: food,
                    isFavorite: isFavorite,
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
                          builder: (context) => FoodDetailScreen(food: food),
                        ),
                      );
                    },
                  ),
                );
              },
              childCount: foods.length,
            ),
          ),
        );
      },
    );
  }

  void _showRatingLegend() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const Padding(
        padding: EdgeInsets.all(AppConstants.paddingMedium),
        child: RatingLegend(),
      ),
    );
  }
}