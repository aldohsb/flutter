import 'package:hive/hive.dart';

part 'expense_entry.g.dart';

@HiveType(typeId: 8)
class ExpenseEntry extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  // Jumlah dalam Rupiah penuh (bukan ribuan)
  @HiveField(2)
  int amount;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  String category;

  ExpenseEntry({
    required this.id,
    required this.name,
    required this.amount,
    required this.date,
    required this.category,
  });
}

/// Item pengeluaran custom yang disimpan user — bisa dipakai ulang
@HiveType(typeId: 9)
class CustomExpenseItem extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String category;

  @HiveField(3)
  DateTime createdAt;

  CustomExpenseItem({
    required this.id,
    required this.name,
    required this.category,
    required this.createdAt,
  });
}

// ── Kategori pengeluaran ─────────────────────────────────────
const List<String> kExpenseCategories = [
  'Makan-Minum',
  'Kebutuhan Rumah Tangga',
  'Kendaraan',
  'Pendidikan',
  'Rutin',
  'Kesehatan',
  'Pakaian',
  'Infaq',
  'Administrasi',
  'Bunga Bank',
  'Lain-lain',
];

// ── Preset item pengeluaran + kategori ───────────────────────
class ExpensePreset {
  final String name;
  final String category;
  const ExpensePreset({required this.name, required this.category});
}

const List<ExpensePreset> kExpensePresets = [
  ExpensePreset(name: 'Alfagift', category: 'Makan-Minum'),
  ExpensePreset(name: 'Jimpitan', category: 'Infaq'),
  ExpensePreset(name: 'Grab', category: 'Makan-Minum'),
  ExpensePreset(name: 'Belanja Mirota', category: 'Kebutuhan Rumah Tangga'),
  ExpensePreset(name: 'Parkir', category: 'Kendaraan'),
  ExpensePreset(name: 'Pertamax Fazzio', category: 'Kendaraan'),
  ExpensePreset(name: 'Ayam geprek', category: 'Makan-Minum'),
  ExpensePreset(name: 'Jajan Indomaret', category: 'Makan-Minum'),
  ExpensePreset(name: 'Gorengan', category: 'Makan-Minum'),
  ExpensePreset(name: 'Nasi padang', category: 'Makan-Minum'),
  ExpensePreset(name: 'Jajan Pasar', category: 'Makan-Minum'),
  ExpensePreset(name: 'Infaq', category: 'Infaq'),
  ExpensePreset(name: 'Indihome', category: 'Rutin'),
  ExpensePreset(name: 'Pulsa Listrik PLN', category: 'Rutin'),
  ExpensePreset(name: 'SPP Hannah', category: 'Pendidikan'),
  ExpensePreset(name: 'SPP Maryam', category: 'Pendidikan'),
  ExpensePreset(name: 'SPP Usamah', category: 'Pendidikan'),
  ExpensePreset(name: 'SPP Aliyya', category: 'Pendidikan'),
  ExpensePreset(name: 'Iuran sampah', category: 'Rutin'),
  ExpensePreset(name: 'Bunga Bank', category: 'Bunga Bank'),
  ExpensePreset(name: 'Biaya kartu', category: 'Administrasi'),
  ExpensePreset(name: 'Belanja Indomaret', category: 'Kebutuhan Rumah Tangga'),
  ExpensePreset(name: 'Frozen food', category: 'Makan-Minum'),
  ExpensePreset(name: 'Obat', category: 'Kesehatan'),
  ExpensePreset(name: 'Skincare', category: 'Kesehatan'),
  ExpensePreset(name: 'Pajak Rekening', category: 'Administrasi'),
  ExpensePreset(name: 'Masker', category: 'Kesehatan'),
  ExpensePreset(name: 'Seragam Maryam', category: 'Pakaian'),
  ExpensePreset(name: 'Gamis Hannah', category: 'Pakaian'),
  ExpensePreset(name: 'Gojek', category: 'Makan-Minum'),
  ExpensePreset(name: 'Buah', category: 'Makan-Minum'),
  ExpensePreset(name: 'Bakso', category: 'Makan-Minum'),
  ExpensePreset(name: 'Daging', category: 'Makan-Minum'),
  ExpensePreset(name: 'Alat tulis', category: 'Pendidikan'),
  ExpensePreset(name: 'Ganti ban depan scoopy', category: 'Kendaraan'),
  ExpensePreset(name: 'Gudeg', category: 'Makan-Minum'),
  ExpensePreset(name: 'Servis AC', category: 'Lain-lain'),
  ExpensePreset(name: 'Beli Mouse', category: 'Lain-lain'),
];

/// Format angka ke Rupiah, misal 125000 -> "Rp125.000"
String formatRupiah(num amount) {
  final isNegative = amount < 0;
  final str = amount.abs().round().toString();
  final buffer = StringBuffer();
  for (int i = 0; i < str.length; i++) {
    final posFromEnd = str.length - i;
    buffer.write(str[i]);
    if (posFromEnd > 1 && posFromEnd % 3 == 1) {
      buffer.write('.');
    }
  }
  return '${isNegative ? '-' : ''}Rp${buffer.toString()}';
}

/// Warna kategori (siklus tetap, dipakai untuk chart/badge)
const Map<String, int> kCategoryColorHex = {
  'Makan-Minum': 0xFFD4882A, // warningAmber
  'Kebutuhan Rumah Tangga': 0xFF6A9A63, // sage500
  'Kendaraan': 0xFF4A7FBD, // blue
  'Pendidikan': 0xFF8A5CB5, // purple
  'Rutin': 0xFF4E9A47, // successGreen
  'Kesehatan': 0xFFD64E4E, // errorRed
  'Pakaian': 0xFFC97AAE, // pink
  'Infaq': 0xFFC9A84C, // accentGold
  'Administrasi': 0xFF5C7A8A, // slate
  'Bunga Bank': 0xFF8B8678, // stone500
  'Lain-lain': 0xFFB5CEB0, // sage300
};