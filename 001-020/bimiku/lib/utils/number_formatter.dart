// class ini berisi fungsi custom untuk memformat angka ala gaya penulisan Indonesia
class NumberFormatter {
  NumberFormatter._(); // constructor privat, class ini hanya utilitas static

  static String formatBmi(double value) { // memformat nilai BMI jadi 1 angka desimal gaya Indonesia
    final rounded = (value * 10).round() / 10; // membulatkan manual ke 1 desimal agar konsisten saat ditampilkan
    final withDot = rounded.toStringAsFixed(1); // mengubah double ke string dengan 1 angka di belakang koma
    return withDot.replaceAll('.', ','); // mengganti titik desimal dengan koma, gaya penulisan angka Indonesia
  }
}