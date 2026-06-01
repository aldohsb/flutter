// model layer — tidak import widget apapun, murni data

enum Mood { senang, oke, netral, sedih, nangis } // enum dipindah ke model agar bisa dipakai semua file

class MoodData {                                  // data statis tiap mood — dikumpulkan dalam satu class
  final String emoji;                             // karakter emoji yang ditampilkan
  final String label;                             // teks deskripsi mood
  final int colorValue;                           // warna dalam bentuk int hex — Color(colorValue) di widget

  const MoodData({                                // const constructor — objek bisa dibuat compile-time
    required this.emoji,
    required this.label,
    required this.colorValue,
  });
}

class MoodEntry {                                 // satu catatan mood — dibuat saat user menekan tombol
  final Mood mood;                                // mood yang dipilih
  final DateTime timestamp;                       // waktu pencatatan — diisi otomatis saat dibuat

  MoodEntry({                                     // constructor tanpa const — timestamp selalu baru
    required this.mood,
    DateTime? timestamp,                          // opsional — jika tidak diisi, pakai waktu sekarang
  }) : timestamp = timestamp ?? DateTime.now();   // ?? = jika null, pakai DateTime.now()
}

// Map data mood — const karena tidak berubah sama sekali
const Map<Mood, MoodData> moodDataMap = {
  Mood.senang: MoodData(emoji: '😄', label: 'Senang banget!',  colorValue: 0xFFFFB347),
  Mood.oke:    MoodData(emoji: '🙂', label: 'Lumayan oke',     colorValue: 0xFF6C63FF),
  Mood.netral: MoodData(emoji: '😐', label: 'Biasa aja',       colorValue: 0xFF4ECDC4),
  Mood.sedih:  MoodData(emoji: '😔', label: 'Agak sedih',      colorValue: 0xFF778CA3),
  Mood.nangis: MoodData(emoji: '😢', label: 'Lagi nggak oke',  colorValue: 0xFF5C6BC0),
};

// urutan tampil tombol — List terpisah karena Map tidak menjamin urutan
const List<Mood> moodOrder = [
  Mood.senang, Mood.oke, Mood.netral, Mood.sedih, Mood.nangis,
];