import 'package:hive/hive.dart';

part 'calorie_entry.g.dart';

@HiveType(typeId: 5)
class CalorieEntry extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String foodName;

  // Total calories (already multiplied by qty)
  @HiveField(2)
  int calories;

  @HiveField(3)
  DateTime date;

  // qty: how many portions — stored for display in log
  @HiveField(4, defaultValue: 1)
  int quantity;

  CalorieEntry({
    required this.id,
    required this.foodName,
    required this.calories,
    required this.date,
    this.quantity = 1,
  });
}

@HiveType(typeId: 6)
class CalorieGoal extends HiveObject {
  @HiveField(0)
  int dailyTargetKcal;

  CalorieGoal({this.dailyTargetKcal = 1500});
}

/// Makanan custom yang disimpan user — bisa dipakai ulang
@HiveType(typeId: 7)
class CustomFood extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  /// Kalori per 1 porsi
  @HiveField(2)
  int caloriesPerServing;

  @HiveField(3)
  DateTime createdAt;

  CustomFood({
    required this.id,
    required this.name,
    required this.caloriesPerServing,
    required this.createdAt,
  });
}

// ── Preset food list ─────────────────────────────────────────
class FoodPreset {
  final String name;
  final int calories;
  const FoodPreset({required this.name, required this.calories});
}

const List<FoodPreset> kFoodPresets = [
  FoodPreset(name: 'Kopi tanpa gula + krimer 4 g', calories: 20),
  FoodPreset(name: 'Nasi 1 sdm', calories: 25),
  FoodPreset(name: 'Malkist gula kecil 1 keping', calories: 35),
  FoodPreset(name: 'Rendang 1 potong', calories: 90),
  FoodPreset(name: 'Kastengel 1 butir', calories: 30),
  FoodPreset(name: 'Ayam goreng 1 potong', calories: 260),
  FoodPreset(name: 'Ayam goreng tepung dada 1 potong', calories: 320),
  FoodPreset(name: 'Ayam goreng tepung sayap 1 potong', calories: 180),
  FoodPreset(name: 'Ayam bakar 1 potong', calories: 250),
  FoodPreset(name: 'Ayam lada hitam 1 sdm', calories: 40),
  FoodPreset(name: 'Ayam suwir 1 sdm', calories: 40),
  FoodPreset(name: 'Dimsum 1 buah', calories: 50),
  FoodPreset(name: 'Indomie rebus 1 bungkus', calories: 380),
  FoodPreset(name: 'Indomie rebus + telur', calories: 460),
  FoodPreset(name: 'Telur rebus 1 butir', calories: 70),
  FoodPreset(name: 'Telur dadar 1 butir', calories: 120),
  FoodPreset(name: 'Kremes 1 sdm', calories: 30),
  FoodPreset(name: 'Sambal 1 sdm', calories: 20),
  FoodPreset(name: 'Tempe goreng tepung 1 buah', calories: 120),
  FoodPreset(name: 'Tahu goreng tepung 1 buah', calories: 100),
  FoodPreset(name: 'Tahu kriuk 1 buah', calories: 50),
  FoodPreset(name: 'Tahu bakso 1 buah', calories: 80),
  FoodPreset(name: 'Tahu gulai 1 potong', calories: 80),
  FoodPreset(name: 'Serundeng + daging 1 potong', calories: 110),
  FoodPreset(name: 'Sop ayam 1 mangkuk', calories: 200),
  FoodPreset(name: 'Roti tawar 1 lembar', calories: 70),
  FoodPreset(name: 'Mentega 1 sdt', calories: 35),
  FoodPreset(name: 'Gula 1 sdt', calories: 16),
  FoodPreset(name: 'Selai coklat 1 sdm', calories: 40),
  FoodPreset(name: 'Meses 1 sdm', calories: 50),
  FoodPreset(name: 'Roti keju 1 buah', calories: 220),
  FoodPreset(name: 'Roti coklat 1 buah', calories: 220),
  FoodPreset(name: 'Roti pisang keju 1 buah', calories: 280),
  FoodPreset(name: 'Roti sosis keju 1 buah', calories: 300),
  FoodPreset(name: 'Pisang goreng + keju 1 buah', calories: 120),
  FoodPreset(name: 'Es kelapa muda tanpa gula 1 gelas', calories: 60),
  FoodPreset(name: 'Es teh manis 1 gelas', calories: 90),
  FoodPreset(name: 'Kue jajanan pasar 1 buah', calories: 150),
  FoodPreset(name: 'Martabak keju 1 potong', calories: 180),
  FoodPreset(name: 'Pastel 1 buah', calories: 220),
  FoodPreset(name: 'Risol 1 buah', calories: 180),
  FoodPreset(name: 'Sumpia 1 buah', calories: 30),
  FoodPreset(name: 'Sosis isi keju 1 buah', calories: 120),
  FoodPreset(name: 'Nasi Padang 1 porsi nasi', calories: 350),
  FoodPreset(name: 'Nasi goreng 1 porsi', calories: 600),
];