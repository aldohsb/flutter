#!/bin/bash

PROJECT_DIR="food_snap"

if [ ! -d "$PROJECT_DIR" ]; then
  flutter create --org com.letterhanna food_snap
fi

cd "$PROJECT_DIR" || exit 1

mkdir -p lib/core/theme
mkdir -p lib/core/data
mkdir -p lib/models
mkdir -p lib/screens
mkdir -p lib/widgets
mkdir -p assets/images/food

touch lib/main.dart
touch lib/core/theme/app_colors.dart
touch lib/core/data/food_data.dart
touch lib/models/food_item.dart
touch lib/screens/food_gallery_screen.dart
touch lib/widgets/food_card_widget.dart
touch lib/widgets/food_card_shimmer.dart

# Buat placeholder gambar makanan (ganti dengan foto asli)
for name in nasi_goreng ayam_bakar soto_betawi gado_gado rendang es_teler; do
  touch "assets/images/food/${name}.jpg"
done

echo ""
echo "✅ Struktur proyek siap!"
echo ""

if command -v tree &> /dev/null; then
  tree -I "build|.dart_tool|.gradle|.idea" --dirsfirst -L 5
else
  find . -not -path "*/build/*" \
         -not -path "*/.dart_tool/*" \
         -not -path "*/.gradle/*" \
         -not -path "*/.idea/*" \
         -maxdepth 5 | sort
fi

echo ""
echo "⚠️  PENTING: Ganti file placeholder di assets/images/food/"
echo "   dengan foto makanan asli sebelum flutter run"
echo ""
echo "Urutan copy paste:"
echo "  1. pubspec.yaml → flutter pub get"
echo "  2. lib/models/food_item.dart"
echo "  3. lib/core/theme/app_colors.dart"
echo "  4. lib/core/data/food_data.dart"
echo "  5. lib/widgets/food_card_shimmer.dart"
echo "  6. lib/widgets/food_card_widget.dart"
echo "  7. lib/screens/food_gallery_screen.dart"
echo "  8. lib/main.dart"
echo "  9. flutter run"