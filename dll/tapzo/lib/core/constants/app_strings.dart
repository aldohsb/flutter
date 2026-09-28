// Kelas berisi kumpulan string statis agar semua teks terpusat, mudah diubah/di-translate nanti
class AppStrings {
  // Constructor privat agar class ini tidak pernah bisa di-instantiate (murni wadah konstanta)
  AppStrings._();

  // Nama aplikasi, dipakai di title MaterialApp dan judul AppBar
  static const String appName = 'Tapzo';
  // Teks kecil penjelas yang tampil di atas angka counter
  static const String subtitle = 'Ketuk untuk menghitung';
  // Label tombol reset, dipakai di FloatingActionButton dan tombol dialog
  static const String resetLabel = 'Reset';
  // Label tombol batal pada dialog konfirmasi reset
  static const String cancelLabel = 'Batal';
  // Judul dialog konfirmasi saat user ingin mereset counter
  static const String resetTitle = 'Reset Counter?';
  // Isi pesan dialog konfirmasi reset, menjelaskan konsekuensi aksi
  static const String resetMessage = 'Angka akan kembali ke 0. Lanjutkan?';
}