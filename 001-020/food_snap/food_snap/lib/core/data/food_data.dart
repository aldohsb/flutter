import '../../../models/food_item.dart';
// Import model FoodItem dari folder models/
// '../../../' = naik 3 level: data/ → core/ → lib/ → lalu masuk models/

abstract class FoodData {
  // abstract class lagi sebagai namespace data
  // Semua data statis disimpan di sini, terpisah dari UI

  static const List<FoodItem> menu = [
    // List<FoodItem> = list yang hanya boleh berisi objek FoodItem
    // const di depan List = seluruh list dan isinya adalah compile-time constant
    // Ini bisa karena FoodItem juga punya const constructor

    FoodItem(
      name: 'Nasi Goreng Spesial',
      description: 'Nasi goreng dengan telur mata sapi, ayam suwir, dan acar. Dimasak dengan bumbu rahasia khas Jawa.',
      price: 28000,
      imagePath: 'assets/images/food/nasi_goreng.jpg',
      category: 'Nasi',
      rating: 4.8,
    ),

    FoodItem(
      name: 'Ayam Bakar Madu',
      description: 'Ayam kampung yang dimarinasi 12 jam, dibakar dengan olesan madu dan kecap manis.',
      price: 45000,
      imagePath: 'assets/images/food/ayam_bakar.jpg',
      category: 'Ayam',
      rating: 4.9,
    ),

    FoodItem(
      name: 'Soto Betawi',
      description: 'Soto kuah santan kaya rempah dengan daging sapi empuk, tomat, dan emping melinjo.',
      price: 32000,
      imagePath: 'assets/images/food/soto_betawi.jpg',
      category: 'Soto',
      rating: 4.7,
    ),

    FoodItem(
      name: 'Gado-Gado',
      description: 'Sayuran segar direbus dengan bumbu kacang spesial, dilengkapi lontong dan kerupuk.',
      price: 22000,
      imagePath: 'assets/images/food/gado_gado.jpg',
      category: 'Sayur',
      rating: 4.6,
      isAvailable: false,
      // Contoh item yang tidak tersedia — card akan ditampilkan berbeda
    ),

    FoodItem(
      name: 'Rendang Sapi',
      description: 'Rendang Padang autentik dimasak slow-cook 4 jam. Daging empuk, bumbu meresap sempurna.',
      price: 55000,
      imagePath: 'assets/images/food/rendang.jpg',
      category: 'Daging',
      rating: 5.0,
    ),

    FoodItem(
      name: 'Es Teler Spesial',
      description: 'Es teler segar dengan alpukat, kelapa muda, nangka, dan cincau. Sirup cocopandan.',
      price: 18000,
      imagePath: 'assets/images/food/es_teler.jpg',
      category: 'Minuman',
      rating: 4.5,
    ),
  ];

  static List<String> get categories {
    // getter yang menghasilkan daftar kategori unik dari data menu
    // Tidak didefinisikan manual agar otomatis update jika menu berubah

    final List<String> cats = menu.map((item) => item.category).toList();
    // .map() → konversi setiap FoodItem ke String category-nya
    // .toList() → ubah Iterable<String> menjadi List<String>

    return ['Semua', ...cats.toSet().toList()];
    // .toSet() → hapus duplikat (kategori yang muncul lebih dari sekali)
    // .toList() → konversi kembali ke List
    // ['Semua', ...] → spread operator (...) untuk gabungkan dua list:
    //   ['Semua'] + hasil set.toList() = ['Semua', 'Nasi', 'Ayam', ...]
  }
}