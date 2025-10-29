import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/food_model.dart';
import '../providers/food_provider.dart';
import '../providers/user_provider.dart';
import '../utils/constants.dart';
import '../widgets/rating_badge.dart';

class FoodDetailScreen extends StatefulWidget {
  final FoodModel food;

  const FoodDetailScreen({
    super.key,
    required this.food,
  });

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavorite();
  }

  Future<void> _checkFavorite() async {
    final userProvider = context.read<UserProvider>();
    if (userProvider.user != null) {
      final isFav = await context.read<FoodProvider>().isFavorite(
            userProvider.user!.id!,
            widget.food.id!,
          );
      setState(() => _isFavorite = isFav);
    }
  }

  Future<void> _toggleFavorite() async {
    final userProvider = context.read<UserProvider>();
    if (userProvider.user != null) {
      await context.read<FoodProvider>().toggleFavorite(
            userProvider.user!.id!,
            widget.food.id!,
          );
      setState(() => _isFavorite = !_isFavorite);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  _buildMacroInfo(),
                  const SizedBox(height: 24),
                  if (widget.food.description != null) ...[
                    _buildDescription(),
                    const SizedBox(height: 24),
                  ],
                  if (widget.food.tips != null) ...[
                    _buildTips(),
                    const SizedBox(height: 24),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      actions: [
        IconButton(
          icon: Icon(
            _isFavorite ? Icons.favorite : Icons.favorite_border,
            color: _isFavorite ? AppConstants.primaryRed : null,
          ),
          onPressed: _toggleFavorite,
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          widget.food.name,
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
                widget.food.ratingColor,
                widget.food.ratingColor.withOpacity(0.7),
              ],
            ),
          ),
          child: Center(
            child: Icon(
              widget.food.category.icon,
              size: 100,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            RatingBadge(rating: widget.food.rating),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: widget.food.ratingColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                border: Border.all(
                  color: widget.food.ratingColor.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    widget.food.category.icon,
                    size: 16,
                    color: widget.food.ratingColor,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    widget.food.category.displayName,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: widget.food.ratingColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMacroInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informasi Nutrisi (per 100g)',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildMacroRow(
              'Kalori',
              '${widget.food.calories.toStringAsFixed(0)} kkal',
              Icons.local_fire_department,
              AppConstants.accentYellow,
            ),
            const Divider(),
            _buildMacroRow(
              'Karbohidrat',
              '${widget.food.carbs.toStringAsFixed(1)} g',
              Icons.grain,
              Colors.orange,
            ),
            const Divider(),
            _buildMacroRow(
              'Protein',
              '${widget.food.protein.toStringAsFixed(1)} g',
              Icons.fitness_center,
              Colors.blue,
            ),
            const Divider(),
            _buildMacroRow(
              'Lemak',
              '${widget.food.fat.toStringAsFixed(1)} g',
              Icons.water_drop,
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMacroRow(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: AppConstants.primaryRed,
                ),
                const SizedBox(width: 8),
                Text(
                  'Deskripsi',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              widget.food.description!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTips() {
    return Card(
      color: AppConstants.accentYellow.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.lightbulb,
                  color: AppConstants.accentYellow,
                ),
                const SizedBox(width: 8),
                Text(
                  'Tips',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              widget.food.tips!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}