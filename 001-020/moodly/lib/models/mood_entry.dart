// ============================================================
// lib/models/mood_entry.dart
// Model data utama Moodly – Blueprint setiap entri mood
//
// KONSEP: Model / Data Class
// Seperti formulir isian: setiap mood yang dicatat HARUS
// punya field yang sama dan bertipe data yang benar.
// Model ini juga bertanggung jawab mengubah dirinya sendiri
// menjadi JSON (untuk disimpan) dan sebaliknya (untuk dibaca).
// ============================================================

// dart:convert menyediakan jsonEncode() dan jsonDecode()
// untuk mengubah Map/List Dart ↔ String JSON
import 'dart:convert';

// ============================================================
// ENUM MoodEmoji
// Enum = tipe data dengan sekumpulan nilai tetap yang terdefinisi
// Lebih aman dari String biasa karena compiler bisa mendeteksi typo
// ============================================================
enum MoodEmoji {
  // Setiap nilai enum punya properti 'emoji' dan 'label'
  // yang didefinisikan di extension di bawah
  verySad,    // 😢
  sad,        // 😕
  neutral,    // 😐
  happy,      // 😊
  veryHappy,  // 🥰
}

// ============================================================
// EXTENSION pada MoodEmoji
// Extension = menambahkan method/properti ke tipe yang sudah ada
// tanpa mengubah atau mewarisi kelas aslinya
// ============================================================
extension MoodEmojiExtension on MoodEmoji {
  // getter 'emoji' – mengembalikan karakter emoji berdasarkan nilai enum
  // Ini seperti switch-case yang menghasilkan nilai
  String get emoji {
    switch (this) {
      case MoodEmoji.verySad:
        return '😢';
      case MoodEmoji.sad:
        return '😕';
      case MoodEmoji.neutral:
        return '😐';
      case MoodEmoji.happy:
        return '😊';
      case MoodEmoji.veryHappy:
        return '🥰';
    }
  }

  // getter 'label' – nama deskriptif dalam Bahasa Indonesia
  String get label {
    switch (this) {
      case MoodEmoji.verySad:
        return 'Sangat Sedih';
      case MoodEmoji.sad:
        return 'Sedih';
      case MoodEmoji.neutral:
        return 'Biasa Aja';
      case MoodEmoji.happy:
        return 'Senang';
      case MoodEmoji.veryHappy:
        return 'Sangat Senang';
    }
  }

  // getter 'score' – nilai numerik 1-5 untuk keperluan chart
  // Skor ini yang akan diplot di BarChart fl_chart nanti
  int get score {
    // index = posisi enum dalam definisinya (verySad=0, sad=1, dst)
    // +1 agar skor mulai dari 1 bukan 0
    return index + 1;
  }

  // getter 'colorIndex' – index ke AppColors.moodColors[]
  // Sama dengan index enum, tidak perlu switch
  int get colorIndex => index;

  // Mengubah enum menjadi String untuk disimpan ke JSON
  // Kita simpan nama enum-nya sebagai String (misal: 'happy')
  String toJson() => name;

  // Mengubah String JSON kembali menjadi MoodEmoji enum
  // static = bisa dipanggil tanpa instansi: MoodEmoji.fromJson('happy')
  static MoodEmoji fromJson(String json) {
    // MoodEmoji.values = list semua nilai enum [verySad, sad, ...]
    // .firstWhere = cari element pertama yang memenuhi kondisi
    // orElse = nilai default jika tidak ditemukan (hindari exception)
    return MoodEmoji.values.firstWhere(
      (e) => e.name == json,
      orElse: () => MoodEmoji.neutral, // Default jika data korup
    );
  }
}

// ============================================================
// CLASS MoodEntry – Blueprint satu entri mood harian
// ============================================================
class MoodEntry {
  // final = nilai tidak bisa diubah setelah objek dibuat (immutable)
  // Immutability = praktik terbaik: data tidak berubah tak terduga
  final String id;          // ID unik setiap entri (timestamp-based)
  final MoodEmoji mood;     // Enum mood yang dipilih user
  final DateTime date;      // Tanggal & waktu pencatatan
  final String note;        // Catatan teks opsional dari user

  // ============================================================
  // CONSTRUCTOR
  // Dipanggil saat membuat objek baru: MoodEntry(...)
  // 'required' = parameter wajib diisi
  // ============================================================
  const MoodEntry({
    required this.id,
    required this.mood,
    required this.date,
    this.note = '', // Default kosong jika tidak diisi
  });

  // ============================================================
  // FACTORY CONSTRUCTOR: create()
  // factory = constructor yang tidak selalu membuat instance baru
  // Dipakai saat ada logika sebelum pembuatan objek
  // create() = shortcut untuk membuat MoodEntry baru dengan ID otomatis
  // ============================================================
  factory MoodEntry.create({
    required MoodEmoji mood,
    String note = '',
    DateTime? date, // '?' = nullable, boleh null
  }) {
    // DateTime.now() menghasilkan waktu saat ini
    final now = date ?? DateTime.now(); // ?? = jika null, pakai DateTime.now()

    return MoodEntry(
      // ID unik dari millisecond sejak epoch (angka yang selalu bertambah)
      // Ini memastikan setiap entri punya ID berbeda
      id: now.millisecondsSinceEpoch.toString(),
      mood: mood,
      date: now,
      note: note,
    );
  }

  // ============================================================
  // copyWith() – Membuat salinan objek dengan beberapa nilai diubah
  //
  // MENGAPA PERLU copyWith?
  // Karena semua field adalah 'final' (tidak bisa diubah langsung).
  // Untuk "mengubah" data, kita buat objek BARU dengan nilai yang diperbarui.
  // Ini pola immutability yang aman dan bersih.
  //
  // Contoh:
  //   entry.copyWith(note: 'Catatan baru') → MoodEntry baru dengan note berbeda
  // ============================================================
  MoodEntry copyWith({
    String? id,       // '?' = opsional, jika tidak diisi pakai nilai lama
    MoodEmoji? mood,
    DateTime? date,
    String? note,
  }) {
    return MoodEntry(
      // Operator '??' berarti: pakai nilai baru jika ada, pakai lama jika null
      id: id ?? this.id,
      mood: mood ?? this.mood,
      date: date ?? this.date,
      note: note ?? this.note,
    );
  }

  // ============================================================
  // SERIALISASI: toMap() dan toJson()
  // Serialisasi = mengubah objek Dart menjadi format yang bisa disimpan
  //
  // Alur: MoodEntry → Map<String,dynamic> → String JSON → SharedPreferences
  // ============================================================

  // toMap() – mengubah MoodEntry menjadi Map (seperti dictionary)
  // Map<String, dynamic>: key=String, value=tipe apa saja
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      // mood.toJson() mengubah enum menjadi String (misal: 'happy')
      'mood': mood.toJson(),
      // date.toIso8601String() = format standar: "2026-06-18T10:30:00.000"
      // ISO 8601 = format tanggal internasional yang mudah di-parse kembali
      'date': date.toIso8601String(),
      'note': note,
    };
  }

  // toJson() – mengubah Map menjadi String JSON
  // jsonEncode() dari dart:convert yang melakukan ini
  String toJson() => jsonEncode(toMap());

  // ============================================================
  // DESERIALISASI: fromMap() dan fromJson()
  // Deserialisasi = kebalikan serialisasi: dari format simpanan ke objek
  //
  // Alur: SharedPreferences → String JSON → Map → MoodEntry
  // ============================================================

  // fromMap() – factory constructor dari Map
  factory MoodEntry.fromMap(Map<String, dynamic> map) {
    return MoodEntry(
      // map['id'] mengambil nilai dengan key 'id'
      // as String = cast tipe (memberitahu Dart ini adalah String)
      id: map['id'] as String,
      // Pakai fromJson() extension untuk mengubah String → MoodEmoji
      mood: MoodEmojiExtension.fromJson(map['mood'] as String),
      // DateTime.parse() mengubah String ISO 8601 kembali ke DateTime
      date: DateTime.parse(map['date'] as String),
      // ?? '' = jika null (data lama tidak punya 'note'), pakai string kosong
      note: (map['note'] as String?) ?? '',
    );
  }

  // fromJson() – factory constructor dari String JSON
  factory MoodEntry.fromJson(String json) {
    // jsonDecode() mengubah String JSON menjadi Map
    // as Map<String, dynamic> = cast tipe hasil decode
    return MoodEntry.fromMap(jsonDecode(json) as Map<String, dynamic>);
  }

  // ============================================================
  // GETTER TAMBAHAN – properti turunan yang berguna
  // getter = properti yang dihitung, bukan disimpan langsung
  // ============================================================

  // moodScore – nilai numerik mood (1-5) langsung dari enum
  int get moodScore => mood.score;

  // emoji – karakter emoji dari mood
  String get emoji => mood.emoji;

  // label – label teks mood dalam bahasa Indonesia
  String get label => mood.label;

  // colorIndex – index warna untuk AppColors.moodColors
  int get colorIndex => mood.colorIndex;

  // hasNote – apakah entri ini punya catatan?
  // Berguna untuk kondisional: if (entry.hasNote) ...
  bool get hasNote => note.trim().isNotEmpty;

  // isToday – apakah entri ini dari hari ini?
  bool get isToday {
    final now = DateTime.now();
    // Bandingkan tahun, bulan, dan hari (abaikan jam/menit/detik)
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  // ============================================================
  // OVERRIDE toString() – representasi teks objek untuk debugging
  // Berguna saat print(entry) di console
  // ============================================================
  @override
  String toString() {
    return 'MoodEntry(id: $id, mood: ${mood.label}, date: $date, note: "$note")';
  }

  // ============================================================
  // OVERRIDE == dan hashCode – untuk perbandingan objek
  //
  // Tanpa ini: dua MoodEntry dengan data sama dianggap BERBEDA
  // (karena Flutter membandingkan referensi memory, bukan isinya)
  // Dengan ini: dua MoodEntry dengan id sama dianggap SAMA
  // ============================================================
  @override
  bool operator ==(Object other) {
    // Cek apakah 'other' adalah instance MoodEntry
    if (identical(this, other)) return true;
    return other is MoodEntry && other.id == id;
  }

  // hashCode harus konsisten dengan == :
  // jika a == b, maka a.hashCode == b.hashCode
  @override
  int get hashCode => id.hashCode;
}