// ============================================================
// lib/services/storage_service.dart
// Layanan penyimpanan data – semua interaksi dengan SharedPreferences
//
// KONSEP: Service Layer / Repository Pattern
// Semua kode yang berhubungan dengan "menyimpan & membaca data"
// dikumpulkan di satu tempat. Widget dan Provider tidak perlu
// tahu cara kerja storage — mereka cukup panggil service ini.
//
// Analogi: Service ini seperti "kasir toko"
//   - Provider (manajer) bilang: "simpan item ini"
//   - StorageService (kasir) yang tahu cara menyimpannya
//   - Widget (pelanggan) tidak perlu tahu prosesnya
//
// PENTING: Semua method di sini adalah ASYNC (Future)
// karena operasi disk tidak instan — app tidak boleh "freeze"
// saat menunggu data disimpan/dibaca
// ============================================================

// shared_preferences: library penyimpanan key-value di device
import 'package:shared_preferences/shared_preferences.dart';

// Import model data kita
import '../models/mood_entry.dart';

class StorageService {
  // ============================================================
  // KONSTANTA KEY
  // Key yang dipakai di SharedPreferences harus konsisten.
  // Jika key berubah, data lama tidak bisa dibaca lagi!
  // Menyimpannya sebagai konstanta mencegah typo.
  // ============================================================

  // Key untuk menyimpan list semua entri mood
  static const String _moodEntriesKey = 'mood_entries';

  // Key untuk menyimpan tanggal terakhir app dibuka
  // Dipakai untuk logika "sudah catat mood hari ini?"
  static const String _lastOpenedKey = 'last_opened_date';

  // ============================================================
  // INSTANCE SharedPreferences
  // Kita cache instance ini agar tidak perlu getInstance()
  // setiap kali melakukan operasi storage
  // ============================================================

  // '_prefs' adalah field privat (prefiks _)
  // Nullable karena belum diinisialisasi saat pertama kali
  SharedPreferences? _prefs;

  // ============================================================
  // _getPrefs() – Lazy initialization SharedPreferences
  //
  // KONSEP: Lazy Initialization
  // Objek tidak dibuat saat class dibuat, tapi saat pertama kali dibutuhkan.
  // Menghemat resource jika ternyata tidak dipakai.
  //
  // Kenapa async? SharedPreferences.getInstance() membaca dari disk,
  // operasi I/O yang tidak instan → harus async
  // ============================================================
  Future<SharedPreferences> _getPrefs() async {
    // Jika sudah ada instance, langsung return (tidak perlu buat lagi)
    // '??=' adalah null-aware assignment: assign hanya jika null
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!; // '!' = yakin tidak null setelah await di atas
  }

  // ============================================================
  // SAVE MOODS – Menyimpan seluruh list MoodEntry ke storage
  //
  // Kenapa menyimpan SEMUA setiap kali?
  // SharedPreferences sederhana: tidak ada "update satu item".
  // Kita simpan seluruh list sebagai List<String> JSON.
  // Trade-off ini OK untuk data kecil seperti mood tracker.
  //
  // Alur:
  //   List<MoodEntry> → List<String JSON> → SharedPreferences
  // ============================================================
  Future<bool> saveMoods(List<MoodEntry> entries) async {
    try {
      // Dapatkan instance SharedPreferences
      final prefs = await _getPrefs();

      // Konversi setiap MoodEntry menjadi String JSON
      // .map() = transformasi setiap elemen
      // .toList() = konversi Iterable ke List
      final jsonList = entries.map((entry) => entry.toJson()).toList();

      // Simpan List<String> ke SharedPreferences
      // setStringList() khusus untuk menyimpan list string
      // Mengembalikan bool: true = berhasil, false = gagal
      final success = await prefs.setStringList(_moodEntriesKey, jsonList);

      return success;
    } catch (e) {
      // catch (e) menangkap error apapun yang terjadi dalam try block
      // Dalam produksi, ini bisa dikirim ke logging service
      // ignore: avoid_print
      print('StorageService.saveMoods error: $e');
      // Return false jika ada error (tidak crash, tapi informasikan kegagalan)
      return false;
    }
  }

  // ============================================================
  // LOAD MOODS – Membaca semua MoodEntry dari storage
  //
  // Alur:
  //   SharedPreferences → List<String JSON> → List<MoodEntry>
  //
  // Return type: Future<List<MoodEntry>>
  // "Di masa depan, akan ada List<MoodEntry>"
  // ============================================================
  Future<List<MoodEntry>> loadMoods() async {
    try {
      final prefs = await _getPrefs();

      // Ambil List<String> dari SharedPreferences
      // getStringList() mengembalikan null jika key tidak ada
      // ?? [] = jika null, pakai list kosong (bukan null → aman)
      final jsonList = prefs.getStringList(_moodEntriesKey) ?? [];

      // Konversi setiap String JSON kembali ke MoodEntry
      // Jika ada satu entry yang gagal di-parse, catch menangkapnya
      final entries = jsonList
          .map((json) => MoodEntry.fromJson(json))
          .toList();

      // Urutkan dari terbaru ke terlama
      // sort() mengubah list di tempat (in-place)
      // b.date.compareTo(a.date) = descending (b > a → b duluan)
      entries.sort((a, b) => b.date.compareTo(a.date));

      return entries;
    } catch (e) {
      // ignore: avoid_print
      print('StorageService.loadMoods error: $e');
      // Return list kosong jika gagal (tidak crash)
      return [];
    }
  }

  // ============================================================
  // ADD MOOD – Menambahkan satu MoodEntry baru
  //
  // Lebih efisien dari saveMoods() untuk penambahan:
  // 1. Load data yang ada
  // 2. Tambahkan entry baru
  // 3. Save seluruhnya
  //
  // Return: MoodEntry yang berhasil disimpan (untuk konfirmasi)
  // atau null jika gagal
  // ============================================================
  Future<MoodEntry?> addMood(MoodEntry entry) async {
    try {
      // Load semua data yang sudah ada
      final entries = await loadMoods();

      // Cek apakah sudah ada entry dengan id yang sama
      // Mencegah duplikasi
      final exists = entries.any((e) => e.id == entry.id);
      // .any() = true jika minimal satu elemen memenuhi kondisi

      if (!exists) {
        // Tambahkan entry baru ke list
        entries.add(entry);

        // Simpan seluruh list yang sudah ditambah
        final success = await saveMoods(entries);

        // Return entry jika berhasil, null jika gagal
        return success ? entry : null;
      }

      // Jika sudah ada (duplikat), kembalikan entry yang ada
      return entries.firstWhere((e) => e.id == entry.id);
    } catch (e) {
      // ignore: avoid_print
      print('StorageService.addMood error: $e');
      return null;
    }
  }

  // ============================================================
  // UPDATE MOOD – Memperbarui satu MoodEntry yang sudah ada
  //
  // Alur:
  // 1. Load semua entries
  // 2. Cari entry dengan id yang sama
  // 3. Ganti dengan entry baru
  // 4. Save seluruhnya
  // ============================================================
  Future<bool> updateMood(MoodEntry updatedEntry) async {
    try {
      final entries = await loadMoods();

      // Cari index entry yang ingin diupdate
      // indexWhere() = cari index elemen pertama yang memenuhi kondisi
      // Mengembalikan -1 jika tidak ditemukan
      final index = entries.indexWhere((e) => e.id == updatedEntry.id);

      if (index == -1) {
        // Entry tidak ditemukan
        return false;
      }

      // Ganti entry lama dengan yang baru di posisi yang sama
      entries[index] = updatedEntry;

      return saveMoods(entries);
    } catch (e) {
      // ignore: avoid_print
      print('StorageService.updateMood error: $e');
      return false;
    }
  }

  // ============================================================
  // DELETE MOOD – Menghapus satu MoodEntry berdasarkan id
  // ============================================================
  Future<bool> deleteMood(String id) async {
    try {
      final entries = await loadMoods();

      // removeWhere() = hapus semua elemen yang memenuhi kondisi
      // (akan hapus satu karena id unik)
      entries.removeWhere((e) => e.id == id);

      return saveMoods(entries);
    } catch (e) {
      // ignore: avoid_print
      print('StorageService.deleteMood error: $e');
      return false;
    }
  }

  // ============================================================
  // CLEAR ALL – Menghapus semua data mood
  // Dipakai untuk fitur "reset" atau testing
  // ============================================================
  Future<bool> clearAllMoods() async {
    try {
      final prefs = await _getPrefs();
      // remove() menghapus satu key dari SharedPreferences
      return prefs.remove(_moodEntriesKey);
    } catch (e) {
      // ignore: avoid_print
      print('StorageService.clearAllMoods error: $e');
      return false;
    }
  }

  // ============================================================
  // GET MOODS BY DATE RANGE – Filter mood dalam rentang tanggal
  //
  // Parameter:
  //   startDate: tanggal mulai (inklusif)
  //   endDate: tanggal akhir (inklusif)
  //
  // Dipakai oleh chart untuk menampilkan data 7 hari terakhir
  // ============================================================
  Future<List<MoodEntry>> getMoodsByDateRange({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final allEntries = await loadMoods();

    // Filter hanya yang datenya dalam rentang
    return allEntries.where((entry) {
      // isAfter / isBefore: membandingkan DateTime
      // Kita ubah ke "awal hari" agar perbandingan bersih
      final entryDay = DateTime(
        entry.date.year,
        entry.date.month,
        entry.date.day,
      );
      final start = DateTime(startDate.year, startDate.month, startDate.day);
      final end = DateTime(endDate.year, endDate.month, endDate.day);

      // Inklusif: entry hari sama dengan start/end JUGA diambil
      return !entryDay.isBefore(start) && !entryDay.isAfter(end);
    }).toList();
  }

  // ============================================================
  // HAS MOOD TODAY – Apakah sudah ada catatan mood hari ini?
  // Dipakai di HomeScreen untuk menampilkan prompt "belum catat"
  // ============================================================
  Future<bool> hasMoodToday() async {
    final entries = await loadMoods();
    final today = DateTime.now();

    // .any() = true jika ada minimal satu entry yang isToday
    return entries.any((entry) => entry.isToday);
  }

  // ============================================================
  // GET TODAY'S MOOD – Ambil mood hari ini (jika ada)
  // Mengembalikan null jika belum ada catatan hari ini
  // ============================================================
  Future<MoodEntry?> getTodaysMood() async {
    final entries = await loadMoods();

    try {
      // firstWhere() melempar StateError jika tidak ada yang cocok
      // orElse: return null sebagai alternatif aman
      return entries.firstWhere(
        (entry) => entry.isToday,
        orElse: () => throw StateError('No mood today'),
      );
    } catch (_) {
      // Jika tidak ada mood hari ini, return null
      return null;
    }
  }

  // ============================================================
  // SAVE / LOAD LAST OPENED DATE
  // Untuk tracking kapan terakhir user buka app
  // ============================================================

  Future<void> saveLastOpenedDate() async {
    final prefs = await _getPrefs();
    // Simpan tanggal hari ini sebagai ISO string
    await prefs.setString(
      _lastOpenedKey,
      DateTime.now().toIso8601String(),
    );
  }

  Future<DateTime?> loadLastOpenedDate() async {
    final prefs = await _getPrefs();
    final dateStr = prefs.getString(_lastOpenedKey);

    // Jika belum pernah disimpan, return null
    if (dateStr == null) return null;

    // Parse kembali dari ISO string ke DateTime
    return DateTime.tryParse(dateStr);
    // tryParse = seperti parse() tapi return null jika gagal (tidak throw)
  }

  // ============================================================
  // GET STORAGE INFO – Informasi debug tentang isi storage
  // Berguna untuk halaman demo di Part 4 ini
  // ============================================================
  Future<Map<String, dynamic>> getStorageInfo() async {
    final entries = await loadMoods();
    final lastOpened = await loadLastOpenedDate();
    final hasToday = await hasMoodToday();

    return {
      'totalEntries': entries.length,
      'hasToday': hasToday,
      'lastOpened': lastOpened?.toIso8601String() ?? 'Belum pernah',
      'oldestEntry': entries.isNotEmpty
          ? entries.last.date.toIso8601String()
          : 'Kosong',
      'newestEntry': entries.isNotEmpty
          ? entries.first.date.toIso8601String()
          : 'Kosong',
    };
  }
}