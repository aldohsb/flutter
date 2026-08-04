import 'package:flutter/material.dart'; // Dialog, animasi, dan widget dasar
import '../models/bmi_category.dart'; // enum kategori untuk memilih ikon yang tepat
import '../models/bmi_result.dart'; // model hasil BMI yang akan ditampilkan
import '../utils/number_formatter.dart'; // formatter angka gaya Indonesia

// widget ini membungkus tampilan AlertDialog hasil BMI, dipanggil lewat method static show()
class BmiResultDialog {
  BmiResultDialog._(); // constructor privat, class ini hanya berisi static method

  static Future<void> show(BuildContext context, BmiResult result) { // menampilkan dialog, mengembalikan Future
    return showDialog<void>( // memunculkan dialog modal di atas layar
      context: context, // context dibutuhkan showDialog untuk tahu di mana harus render
      builder: (context) => Dialog( // Dialog polos agar bisa kita custom bentuknya sepenuhnya
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)), // sudut membulat besar, kesan modern
        child: Padding( // jarak dalam dialog
          padding: const EdgeInsets.all(24),
          child: Column( // menyusun ikon, angka, label, dan tombol secara vertikal
            mainAxisSize: MainAxisSize.min, // dialog setinggi kontennya saja, tidak memaksa penuh layar
            children: [
              TweenAnimationBuilder<double>( // animasi scale-in saat dialog muncul, tanpa perlu AnimationController manual
                tween: Tween(begin: 0.6, end: 1), // dari 60% ukuran ke ukuran penuh
                duration: const Duration(milliseconds: 350), // durasi animasi masuk
                curve: Curves.easeOutBack, // curve dengan sedikit overshoot, terasa hidup
                builder: (context, scale, child) => Transform.scale(scale: scale, child: child), // menerapkan scale ke child
                child: CircleAvatar( // lingkaran ikon berwarna sesuai kategori
                  radius: 36,
                  backgroundColor: result.category.color.withValues(alpha: 0.15), // latar lingkaran transparan
                  child: Icon(_iconFor(result.category), size: 36, color: result.category.color), // ikon sesuai kategori
                ),
              ),
              const SizedBox(height: 20), // jarak setelah ikon
              Text( // angka BMI besar
                NumberFormatter.formatBmi(result.bmiValue), // format custom gaya Indonesia, misal "22,9"
                style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: result.category.color),
              ),
              const SizedBox(height: 4), // jarak kecil sebelum label
              Text( // label kategori
                result.category.label, // teks kategori, misal "Berat Badan Normal"
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: result.category.color),
              ),
              const SizedBox(height: 24), // jarak sebelum tombol
              SizedBox( // tombol tutup full width
                width: double.infinity,
                child: FilledButton( // tombol solid untuk aksi utama menutup dialog
                  onPressed: () => Navigator.of(context).pop(), // menutup dialog saat ditekan
                  style: FilledButton.styleFrom( // gaya visual tombol
                    backgroundColor: result.category.color, // warna tombol mengikuti kategori hasil
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Tutup'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static IconData _iconFor(BmiCategory category) { // memilih ikon ekspresif sesuai kategori BMI
    switch (category) { // mencocokkan enum kategori, compiler memastikan semua case tertangani
      case BmiCategory.underweight:
        return Icons.trending_down_rounded; // menandakan berat di bawah normal
      case BmiCategory.normal:
        return Icons.check_circle_rounded; // menandakan kondisi sehat
      case BmiCategory.overweight:
        return Icons.trending_up_rounded; // menandakan berat di atas normal
      case BmiCategory.obese:
        return Icons.warning_rounded; // menandakan perlu perhatian lebih
    }
  }
}