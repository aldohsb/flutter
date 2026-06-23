// ============================================================
// main.dart (Part 4 update)
// Demo interaktif StorageService:
// - Simpan mood ke SharedPreferences
// - Baca kembali dari storage
// - Hapus entri
// - Lihat info storage
// Semua operasi REAL menggunakan SharedPreferences sungguhan!
// ============================================================

import 'package:flutter/material.dart';

import 'package:moodly/theme/app_theme.dart';
import 'package:moodly/theme/app_colors.dart';
import 'package:moodly/theme/app_text_styles.dart';
import 'package:moodly/models/mood_entry.dart';
import 'package:moodly/utils/mood_constants.dart';
import 'package:moodly/utils/date_formatter.dart';

// Import service baru yang kita buat di Part 4
import 'package:moodly/services/storage_service.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized() WAJIB dipanggil sebelum
  // kode async di main(). Ini menginisialisasi binding Flutter
  // agar plugin (SharedPreferences) bisa bekerja.
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MoodlyApp());
}

class MoodlyApp extends StatelessWidget {
  const MoodlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moodly',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const StorageDemoScreen(),
    );
  }
}

// ============================================================
// StorageDemoScreen – Demo CRUD StorageService
// C = Create (tambah mood)
// R = Read (baca semua mood)
// U = Update (tidak di-demo tapi ada di service)
// D = Delete (hapus mood)
// ============================================================
class StorageDemoScreen extends StatefulWidget {
  const StorageDemoScreen({super.key});

  @override
  State<StorageDemoScreen> createState() => _StorageDemoScreenState();
}

class _StorageDemoScreenState extends State<StorageDemoScreen> {
  // Instance StorageService – satu instance untuk seluruh screen
  final StorageService _storage = StorageService();

  // State: daftar mood yang sudah dimuat dari storage
  List<MoodEntry> _entries = [];

  // State: status loading (saat operasi async sedang berjalan)
  bool _isLoading = false;

  // State: pesan log operasi terakhir
  String _logMessage = 'Tap tombol untuk mulai operasi storage';

  // State: mood yang dipilih untuk ditambahkan
  MoodEmoji? _selectedMood;

  // ============================================================
  // initState() – dipanggil SEKALI saat widget pertama dibuat
  // Tempat yang tepat untuk load data awal
  // ============================================================
  @override
  void initState() {
    super.initState(); // Wajib panggil super.initState() pertama
    // Load data dari storage saat screen pertama muncul
    _loadEntries();
    // Simpan tanggal buka app
    _storage.saveLastOpenedDate();
  }

  // ============================================================
  // OPERASI ASYNC – semua method yang menyentuh storage
  // ============================================================

  // Load semua entries dari storage
  Future<void> _loadEntries() async {
    // setState dengan isLoading = true → tampilkan loading indicator
    setState(() => _isLoading = true);

    // await = tunggu sampai Future selesai
    final entries = await _storage.loadMoods();

    // setState lagi untuk update UI dengan data baru
    setState(() {
      _entries = entries;
      _isLoading = false;
      _logMessage = '✅ Loaded ${entries.length} entries dari storage';
    });
  }

  // Tambah mood baru ke storage
  Future<void> _addMood() async {
    // Guard: tidak bisa tambah jika belum pilih mood
    if (_selectedMood == null) {
      setState(() => _logMessage = '⚠️ Pilih emoji mood dulu!');
      return;
    }

    setState(() => _isLoading = true);

    // Buat MoodEntry baru menggunakan factory constructor
    final newEntry = MoodEntry.create(
      mood: _selectedMood!,
      note: 'Demo entry – ${DateFormatter.formatTime(DateTime.now())}',
    );

    // Simpan ke storage via service
    final saved = await _storage.addMood(newEntry);

    if (saved != null) {
      // Reload untuk menampilkan data terbaru
      await _loadEntries();
      setState(() {
        _logMessage =
            '✅ Mood "${newEntry.label}" berhasil disimpan! ID: ${newEntry.id}';
        _selectedMood = null; // Reset pilihan setelah simpan
      });
    } else {
      setState(() {
        _isLoading = false;
        _logMessage = '❌ Gagal menyimpan mood!';
      });
    }
  }

  // Hapus satu entry dari storage
  Future<void> _deleteEntry(MoodEntry entry) async {
    setState(() => _isLoading = true);

    final success = await _storage.deleteMood(entry.id);

    if (success) {
      await _loadEntries();
      setState(() {
        _logMessage = '🗑️ Entry "${entry.label}" berhasil dihapus';
      });
    } else {
      setState(() {
        _isLoading = false;
        _logMessage = '❌ Gagal menghapus entry!';
      });
    }
  }

  // Hapus semua data
  Future<void> _clearAll() async {
    // Konfirmasi dulu via dialog
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Semua?'),
        content: const Text('Semua data mood akan dihapus permanen.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    // Jika user tap "Batal" atau dismiss dialog, confirm = null atau false
    if (confirm != true) return;

    setState(() => _isLoading = true);
    await _storage.clearAllMoods();
    await _loadEntries();
    setState(() => _logMessage = '🗑️ Semua data dihapus');
  }

  // ============================================================
  // BUILD – UI utama
  // ============================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('💾 Part 4 – Storage Demo'),
        // actions = widget di kanan AppBar
        actions: [
          // Tombol refresh
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: _loadEntries,
            tooltip: 'Reload dari storage',
          ),
        ],
      ),
      body: Column(
        children: [
          // ====================================================
          // LOG MESSAGE – Pesan status operasi terakhir
          // ====================================================
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: double.infinity, // Lebar penuh
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            color: AppColors.surfaceSecondary,
            child: Text(
              _logMessage,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),

          // ====================================================
          // PANEL TAMBAH MOOD
          // ====================================================
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pilih mood & simpan:', style: AppTextStyles.headlineSmall),
                const SizedBox(height: 12),

                // Baris emoji pilihan
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: MoodConstants.allMoods.map((config) {
                    final isSelected = _selectedMood == config.mood;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedMood = config.mood),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        width: isSelected ? 58 : 50,
                        height: isSelected ? 58 : 50,
                        decoration: BoxDecoration(
                          color: config.color,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: config.shadowColor,
                              offset: Offset(0, isSelected ? 6 : 4),
                              blurRadius: 0,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            config.emoji,
                            style: TextStyle(fontSize: isSelected ? 28 : 22),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 12),

                // Tombol simpan – hanya aktif jika ada pilihan
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: _isLoading ? null : _addMood,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        // Warna abu-abu jika loading/tidak ada pilihan
                        color: _selectedMood != null
                            ? AppColors.pink
                            : AppColors.border,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: _selectedMood != null
                                ? AppColors.pinkShadow
                                : AppColors.textHint,
                            offset: const Offset(0, 5),
                            blurRadius: 0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          _isLoading ? 'Menyimpan...' : '💾 Simpan ke Storage',
                          style: AppTextStyles.labelLarge,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // ====================================================
          // HEADER DAFTAR + TOMBOL CLEAR
          // ====================================================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dari Storage (${_entries.length} entries):',
                  style: AppTextStyles.headlineSmall,
                ),
                // Tampilkan tombol "Hapus Semua" hanya jika ada data
                if (_entries.isNotEmpty)
                  TextButton(
                    onPressed: _clearAll,
                    child: Text(
                      'Hapus Semua',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.red.shade400,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // ====================================================
          // LIST ENTRIES – hasil baca dari storage
          // ====================================================
          Expanded(
            // Expanded = mengisi sisa ruang vertikal
            child: _isLoading
                // Tampilkan loading spinner saat operasi berlangsung
                ? const Center(child: CircularProgressIndicator())
                : _entries.isEmpty
                    // Tampilkan pesan kosong jika tidak ada data
                    ? _buildEmptyState()
                    // Tampilkan list jika ada data
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        // itemCount = jumlah item dalam list
                        itemCount: _entries.length,
                        // itemBuilder dipanggil untuk setiap item
                        // index = posisi item (0, 1, 2, ...)
                        itemBuilder: (context, index) {
                          final entry = _entries[index];
                          return _EntryCard(
                            entry: entry,
                            // Kirim callback untuk hapus
                            onDelete: () => _deleteEntry(entry),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  // Widget saat list kosong
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('📭', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 12),
          Text(
            'Belum ada data di storage',
            style: AppTextStyles.bodyMedium,
          ),
          const SizedBox(height: 4),
          Text(
            'Pilih mood dan tap "Simpan" untuk mencoba',
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }
}

// ============================================================
// Widget _EntryCard – Satu kartu entri mood di list
// ============================================================
class _EntryCard extends StatelessWidget {
  final MoodEntry entry;
  final VoidCallback onDelete;

  const _EntryCard({
    required this.entry,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Lingkaran emoji
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.moodColors[entry.colorIndex],
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.moodShadowColors[entry.colorIndex],
                  offset: const Offset(0, 3),
                  blurRadius: 0,
                ),
              ],
            ),
            child: Center(
              child: Text(entry.emoji,
                  style: const TextStyle(fontSize: 22)),
            ),
          ),
          const SizedBox(width: 12),

          // Data entry
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.label, style: AppTextStyles.headlineSmall),
                Text(
                  DateFormatter.formatRelative(entry.date),
                  style: AppTextStyles.bodySmall,
                ),
                // Tampilkan note jika ada
                if (entry.hasNote)
                  Text(
                    entry.note,
                    style: AppTextStyles.bodySmall,
                    // Batasi 1 baris, sisanya "..."
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),

          // Tombol hapus
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            color: AppColors.textHint,
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}