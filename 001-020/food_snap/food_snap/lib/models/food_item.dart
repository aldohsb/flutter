class FoodItem {
  final String name;

  final String description;

  final double price;

  final String imagePath;

  final String category;

  final double rating;

  final bool isAvailable;

  const FoodItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.category,
    required this.rating,
    this.isAvailable = true,
  });

  String get formattedPrice {
    return 'Rp ${price.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]}.',
        )}';
  }
}
