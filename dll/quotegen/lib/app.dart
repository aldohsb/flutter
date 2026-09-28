// app.dart
// UPDATE: mengganti Text polos dengan QuoteCard yang baru kita buat.
// Interaksi tap-to-change masih dipertahankan untuk sementara sampai Tahap 8
// (di mana kita ganti dengan tombol asli).

import 'package:flutter/material.dart'; // widget dasar Material Design
import 'theme/app_theme.dart'; // tema kustom dari Tahap 2
import 'data/quotes_repository.dart'; // repository dari Tahap 4
import 'controllers/quote_controller.dart'; // controller dari Tahap 5
import 'widgets/quote_card.dart'; // widget Card baru yang baru kita buat

class QuotegenApp extends StatefulWidget {
  const QuotegenApp({super.key});

  @override
  State<QuotegenApp> createState() => _QuotegenAppState();
}

class _QuotegenAppState extends State<QuotegenApp> {
  final QuotesRepository _repository = QuotesRepository(); // instance repository, dibuat sekali

  late final QuoteController _controller; // controller, diisi di initState

  @override
  void initState() {
    super.initState(); // wajib panggil super lebih dulu
    _controller = QuoteController(repository: _repository); // inisialisasi controller dengan repository
  }

  @override
  void dispose() {
    _controller.dispose(); // bersihkan resource ChangeNotifier
    super.dispose(); // wajib panggil super setelah cleanup
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quotegen',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: Scaffold(
        body: SafeArea(
          // SafeArea mencegah konten tertutup notch/status bar di berbagai platform
          child: Center(
            child: ListenableBuilder(
              listenable: _controller, // mendengarkan perubahan dari controller
              builder: (BuildContext context, Widget? child) {
                // builder dipanggil ulang otomatis tiap notifyListeners() terpicu
                return GestureDetector(
                  onTap: _controller.nextQuote, // tap untuk ganti kutipan (sementara, sebelum Tahap 8)
                  child: QuoteCard(
                    quote: _controller.currentQuote, // pass kutipan aktif ke QuoteCard
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}