import 'package:flutter/material.dart';                            // import framework Flutter
import 'screens/slider_screen.dart';                               // import layar utama — path relatif

void main() => runApp(const SizeSliderApp());                      // titik masuk — arrow function karena 1 ekspresi

class SizeSliderApp extends StatelessWidget {                      // root widget — hanya konfigurasi tema dan MaterialApp
  const SizeSliderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sizeSlider',
      debugShowCheckedModeBanner: false,                           // hilangkan banner debug
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00897B),                      // teal — warna benih tema
          brightness: Brightness.light,                            // mode terang
        ),
        useMaterial3: true,                                        // aktifkan Material Design 3
      ),
      home: const SliderScreen(),                                  // layar utama dari screens/
    );
  }
}