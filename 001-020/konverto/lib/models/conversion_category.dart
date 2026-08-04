// Enum ini merepresentasikan tiga kategori konversi yang didukung aplikasi Konverto
enum UnitCategory {
  length, // kategori untuk konversi satuan panjang
  weight, // kategori untuk konversi satuan berat
  temperature, // kategori untuk konversi satuan suhu
}

// Extension untuk memberi label tampilan (Bahasa Indonesia) pada setiap kategori
extension UnitCategoryLabel on UnitCategory {
  String get label { // getter untuk mengambil teks label yang ramah pengguna
    switch (this) { // cek nilai enum saat ini
      case UnitCategory.length: // jika kategori panjang
        return 'Panjang'; // tampilkan teks "Panjang"
      case UnitCategory.weight: // jika kategori berat
        return 'Berat'; // tampilkan teks "Berat"
      case UnitCategory.temperature: // jika kategori suhu
        return 'Suhu'; // tampilkan teks "Suhu"
    }
  }
}