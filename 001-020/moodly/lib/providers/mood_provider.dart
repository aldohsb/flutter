// ============================================================
// lib/providers/mood_provider.dart
// State Management utama Moodly – jantung seluruh aplikasi
//
// KONSEP: Provider + ChangeNotifier
//
// Bayangkan MoodProvider seperti "papan pengumuman kantor":
//   - Data (list mood, status loading) dipasang di papan
//   - Semua widget yang butuh data "berlangganan" ke papan ini
//   - Saat papan diupdate (notifyListeners), semua pelanggan
//     otomatis mendapat info terbaru dan rebuild tampilan mereka
//
// Tanpa Provider: setiap widget harus kelola data sendiri,
//   sulit berbagi data antar halaman.
// Dengan Provider: satu sumber kebenaran (single source of truth)
//   yang diakses dari mana saja dalam widget tree.
// ============================================================

// foundation.dart menyediakan ChangeNotifier
import 'package:flutter/foundation.dart';

import '../models/mood_entry.dart';
import '../services/storage_service.dart';
import '../utils/mood_constants.dart';

// ============================================================
// ENUM AppStatus – status loading aplikasi
// Digunakan untuk menentukan apa yang ditampilkan di UI:
//   initial  → belum ada operasi apapun
//   loading  → sedang memuat/menyimpan data
//   success  → operasi berhasil
//   error    → operasi gagal
// ============================================================
enum AppStatus { initial, loading, success, error }

// ============================================================
// CLASS MoodProvider extends ChangeNotifier
//
// 'extends' = MoodProvider mewarisi semua kemampuan ChangeNotifier
// ChangeNotifier menyediakan:
//   - notifyListeners() → memberitahu semua widget yang "mendengarkan"
//   - addListener() / removeListener() → manajemen listener
// ============================================================
class MoodProvider extends ChangeNotifier {
  // ============================================================
  // DEPENDENCIES – service yang dibutuhkan provider ini
  // Dependency Injection: service diberikan dari luar,
  // bukan dibuat di dalam. Memudahkan testing dan fleksibilitas.
  // ============================================================
  final StorageService _storage;

  // Constructor: wajib berikan StorageService saat buat MoodProvider
  MoodProvider({StorageService? storage})
    // Jika tidak diberikan, buat instance baru (default)
    : _storage = storage ?? StorageService();

  // ============================================================
  // PRIVATE STATE – data yang dikelola provider ini
  // Private (prefiks _) = hanya bisa diakses dalam class ini
  // Widget mengakses via getter publik di bawah
  // ============================================================

  // List semua entri mood, diurutkan terbaru dulu
  List<MoodEntry> _entries = [];

  // Status operasi saat ini
  AppStatus _status = AppStatus.initial;

  // Pesan error jika ada
  String? _errorMessage;

  // Mood yang sedang dipilih user di form input (belum disimpan)
  MoodEmoji? _selectedMood;

  // Apakah sudah ada mood yang dicatat hari ini?
  bool _hasMoodToday = false;

  // Entry mood hari ini (null jika belum ada)
  MoodEntry? _todaysMood;

  // ============================================================
  // PUBLIC GETTERS – akses data dari widget
  // Getter = properti yang "dihitung", bukan disimpan langsung
  // Widget TIDAK bisa mengubah state langsung, hanya baca via getter
  // ============================================================

  // Semua entries (salinan list, bukan referensi asli)
  // List.from() membuat salinan baru agar widget tidak bisa
  // memodifikasi _entries langsung (immutability terjaga)
  List<MoodEntry> get entries => List.from(_entries);

  // Status loading saat ini
  AppStatus get status => _status;

  // Pesan error
  String? get errorMessage => _errorMessage;

  // Mood yang dipilih di form
  MoodEmoji? get selectedMood => _selectedMood;

  // Apakah sudah catat hari ini?
  bool get hasMoodToday => _hasMoodToday;

  // Mood hari ini
  MoodEntry? get todaysMood => _todaysMood;

  // ============================================================
  // COMPUTED GETTERS – properti turunan yang sering dipakai
  // Dihitung ulang setiap kali dipanggil dari data terkini
  // ============================================================

  // Apakah sedang loading?
  bool get isLoading => _status == AppStatus.loading;

  // Apakah ada error?
  bool get hasError => _status == AppStatus.error;

  // Apakah ada data?
  bool get hasEntries => _entries.isNotEmpty;

  // Jumlah total entries
  int get totalEntries => _entries.length;

  // Entries 7 hari terakhir (untuk chart)
  List<MoodEntry> get recentEntries {
    final cutoff = DateTime.now().subtract(
      const Duration(days: MoodConstants.chartDaysRange),
    );
    // where() = filter: hanya ambil yang tanggalnya setelah cutoff
    return _entries.where((e) => e.date.isAfter(cutoff)).toList();
  }

  // Rata-rata skor mood dari semua entries
  // Mengembalikan null jika tidak ada data
  double? get averageMoodScore {
    if (_entries.isEmpty) return null;
    // reduce() = akumulasi: jumlahkan semua moodScore
    final total = _entries.fold<int>(
      0, // Nilai awal akumulator
      (sum, entry) => sum + entry.moodScore,
      // sum = akumulator, entry = element saat ini
    );
    // Hitung rata-rata: total dibagi jumlah entries
    return total / _entries.length;
  }

  // Data chart: Map dari weekday (1-7) ke rata-rata skor
  // Dipakai oleh fl_chart di ChartScreen
  Map<int, double> get chartData {
    final result = <int, double>{};
    // Group entries berdasarkan hari dalam minggu
    final grouped = <int, List<int>>{};

    for (final entry in recentEntries) {
      final day = entry.date.weekday; // 1=Senin, 7=Minggu
      // putIfAbsent = tambahkan key baru dengan value default jika belum ada
      grouped.putIfAbsent(day, () => []).add(entry.moodScore);
    }

    // Hitung rata-rata per hari
    grouped.forEach((day, scores) {
      final avg = scores.fold(0, (a, b) => a + b) / scores.length;
      result[day] = avg;
    });

    return result;
  }

  // Distribusi mood: berapa kali setiap MoodEmoji dipakai
  // Untuk statistik di halaman chart
  Map<MoodEmoji, int> get moodDistribution {
    final result = <MoodEmoji, int>{};
    for (final entry in _entries) {
      // update() = update value jika key ada, atau set initial jika belum
      result.update(
        entry.mood,
        (count) => count + 1, // Tambah 1 jika sudah ada
        ifAbsent: () => 1,    // Set 1 jika belum ada
      );
    }
    return result;
  }

  // ============================================================
  // ACTIONS – method yang mengubah state
  // Semua yang mengubah data harus:
  // 1. Update _status ke loading
  // 2. Lakukan operasi async
  // 3. Update state dengan hasil
  // 4. Panggil notifyListeners()
  // ============================================================

  // ============================================================
  // loadEntries() – Muat semua data dari storage
  // Dipanggil saat app pertama kali dibuka (di main.dart)
  // ============================================================
  Future<void> loadEntries() async {
    // Set status loading → UI tampilkan spinner
    _setStatus(AppStatus.loading);

    try {
      // Muat dari storage (async, bisa beberapa ms)
      final entries = await _storage.loadMoods();
      final todaysMood = await _storage.getTodaysMood();

      // Update semua state sekaligus
      _entries = entries;
      _todaysMood = todaysMood;
      _hasMoodToday = todaysMood != null;

      _setStatus(AppStatus.success);
    } catch (e) {
      // Jika gagal, simpan pesan error
      _setError('Gagal memuat data: ${e.toString()}');
    }
  }

  // ============================================================
  // addEntry() – Tambah mood baru
  // Dipanggil dari AddMoodScreen saat user tap "Simpan"
  // ============================================================
  Future<bool> addEntry({
    required MoodEmoji mood,
    String note = '',
    DateTime? date,
  }) async {
    _setStatus(AppStatus.loading);

    try {
      // Buat objek MoodEntry baru
      final newEntry = MoodEntry.create(
        mood: mood,
        note: note,
        date: date,
      );

      // Simpan ke storage via service
      final saved = await _storage.addMood(newEntry);

      if (saved == null) {
        // Null artinya gagal disimpan
        _setError('Gagal menyimpan mood');
        return false;
      }

      // Tambahkan ke awal list (terbaru di atas)
      _entries.insert(0, saved);

      // Update today's mood jika entri ini untuk hari ini
      if (saved.isToday) {
        _todaysMood = saved;
        _hasMoodToday = true;
      }

      // Reset selected mood
      _selectedMood = null;

      _setStatus(AppStatus.success);
      return true; // Berhasil
    } catch (e) {
      _setError('Error saat menyimpan: ${e.toString()}');
      return false;
    }
  }

  // ============================================================
  // deleteEntry() – Hapus satu entry berdasarkan id
  // ============================================================
  Future<bool> deleteEntry(String id) async {
    _setStatus(AppStatus.loading);

    try {
      final success = await _storage.deleteMood(id);

      if (!success) {
        _setError('Gagal menghapus mood');
        return false;
      }

      // Cari dan hapus dari list lokal
      // removeWhere() = hapus semua element yang memenuhi kondisi
      _entries.removeWhere((e) => e.id == id);

      // Jika yang dihapus adalah mood hari ini, reset
      if (_todaysMood?.id == id) {
        _todaysMood = null;
        _hasMoodToday = false;
      }

      _setStatus(AppStatus.success);
      return true;
    } catch (e) {
      _setError('Error saat menghapus: ${e.toString()}');
      return false;
    }
  }

  // ============================================================
  // selectMood() – Simpan pilihan emoji sementara (di form)
  // TIDAK menyimpan ke storage, hanya update state UI
  // ============================================================
  void selectMood(MoodEmoji mood) {
    _selectedMood = mood;
    // notifyListeners() langsung (tidak perlu async)
    notifyListeners();
  }

  // ============================================================
  // clearSelectedMood() – Reset pilihan emoji
  // Dipanggil setelah form di-submit atau dibatalkan
  // ============================================================
  void clearSelectedMood() {
    _selectedMood = null;
    notifyListeners();
  }

  // ============================================================
  // clearError() – Bersihkan pesan error
  // Dipanggil setelah user dismiss error notification
  // ============================================================
  void clearError() {
    _errorMessage = null;
    if (_status == AppStatus.error) {
      _status = AppStatus.success;
    }
    notifyListeners();
  }

  // ============================================================
  // getEntriesForDay() – Ambil semua entries untuk hari tertentu
  // Berguna untuk HistoryScreen grouping per hari
  // ============================================================
  List<MoodEntry> getEntriesForDay(DateTime day) {
    return _entries.where((entry) {
      return entry.date.year == day.year &&
          entry.date.month == day.month &&
          entry.date.day == day.day;
    }).toList();
  }

  // ============================================================
  // getEntriesForMonth() – Ambil semua entries untuk bulan tertentu
  // ============================================================
  List<MoodEntry> getEntriesForMonth(int year, int month) {
    return _entries.where((entry) {
      return entry.date.year == year && entry.date.month == month;
    }).toList();
  }

  // ============================================================
  // PRIVATE HELPERS – hanya digunakan dalam class ini
  // ============================================================

  // _setStatus() – update status dan notify semua listener
  void _setStatus(AppStatus status) {
    _status = status;
    // Hapus error message saat status berubah ke non-error
    if (status != AppStatus.error) {
      _errorMessage = null;
    }
    // 📢 Beritahu semua widget yang "mendengarkan" provider ini
    // Mereka akan memanggil build() ulang dengan data terbaru
    notifyListeners();
  }

  // _setError() – set status error dengan pesan
  void _setError(String message) {
    _status = AppStatus.error;
    _errorMessage = message;
    notifyListeners();
  }
}