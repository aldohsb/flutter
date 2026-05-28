import 'package:flutter/material.dart'; // import framework utama Flutter

enum Mood { senang, oke, netral, sedih, nangis } // 5 nilai mood — tipe aman, tidak bisa salah ketik

void main() {
  runApp(const MoodjarApp()); // titik masuk aplikasi
}

class MoodjarApp extends StatelessWidget {
  const MoodjarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moodjar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
        ),
        useMaterial3: true,
      ),
      home: const MoodScreen(),
    );
  }
}

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  Mood? _selectedMood; // mood aktif — null berarti belum ada pilihan

  final Map<Mood, Map<String, dynamic>> _moodData = {
    Mood.senang: {'emoji': '😄', 'label': 'Senang banget!',  'color': 0xFFFFB347},
    Mood.oke:    {'emoji': '🙂', 'label': 'Lumayan oke',     'color': 0xFF6C63FF},
    Mood.netral: {'emoji': '😐', 'label': 'Biasa aja',       'color': 0xFF4ECDC4},
    Mood.sedih:  {'emoji': '😔', 'label': 'Agak sedih',      'color': 0xFF778CA3},
    Mood.nangis: {'emoji': '😢', 'label': 'Lagi nggak oke',  'color': 0xFF5C6BC0},
  };

  final List<Mood> _moodOrder = [ // urutan tetap — Map tidak menjamin urutan
    Mood.senang, Mood.oke, Mood.netral, Mood.sedih, Mood.nangis,
  ];

  void _selectMood(Mood mood) {
    setState(() {
      _selectedMood = mood; // update state → Flutter rebuild semua widget yang bergantung
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              _buildHeader(),
              const SizedBox(height: 48),
              _buildMoodCard(),
              const SizedBox(height: 32),
              _buildMoodButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Halo! 👋',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 4),
        const Text(
          'Gimana perasaanmu\nhari ini?',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A2E),
            height: 1.3,
          ),
        ),
      ],
    );
  }

  Widget _buildMoodCard() {
    final bool hasMood    = _selectedMood != null;          // true jika user sudah memilih mood
    final String emoji    = hasMood
        ? _moodData[_selectedMood]!['emoji'] as String
        : '😶';
    final String label    = hasMood
        ? _moodData[_selectedMood]!['label'] as String
        : 'Pilih moodmu';
    final String sub      = hasMood
        ? 'Mood kamu hari ini tercatat ✓'
        : 'Ketuk salah satu emoji di bawah';
    final Color cardColor = hasMood
        ? Color(_moodData[_selectedMood]!['color'] as int)
        : const Color(0xFF6C63FF);

    return AnimatedContainer(                               // ganti Container → AnimatedContainer
      duration: const Duration(milliseconds: 350),         // durasi transisi semua properti yang berubah
      curve: Curves.easeOutCubic,                          // kurva melambat di akhir — terasa natural
      width: double.infinity,
      height: hasMood ? 260.0 : 220.0,                    // tinggi beranimasi: kecil → besar saat dipilih
      decoration: BoxDecoration(
        color: cardColor,                                   // perubahan warna otomatis dianimasikan
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: cardColor.withOpacity(0.40),            // bayangan ikut warna baru
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TweenAnimationBuilder<double>(                   // animasi skala emoji saat berganti
            key: ValueKey(emoji),                          // key berubah saat emoji baru → rebuild animasi dari awal
            tween: Tween(begin: 0.5, end: 1.0),           // mulai dari setengah ukuran, menuju ukuran penuh
            duration: const Duration(milliseconds: 400),  // durasi animasi skala emoji
            curve: Curves.elasticOut,                     // efek "memantul" di akhir — terasa hidup
            builder: (context, value, child) {
              return Transform.scale(                      // terapkan skala dari nilai tween
                scale: value,                             // value bergerak 0.5 → 1.0 sesuai kurva
                child: child,                             // child adalah widget emoji di bawah
              );
            },
            child: Text(                                  // child dipassing ke builder — tidak rebuild tiap frame
              emoji,
              style: const TextStyle(fontSize: 64),
            ),
          ),
          const SizedBox(height: 12),
          AnimatedSwitcher(                               // fade antar teks saat label berubah
            duration: const Duration(milliseconds: 250),
            child: Text(
              label,
              key: ValueKey(label),                      // key berbeda = widget baru = animasi fade
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 4),
          AnimatedSwitcher(                              // fade untuk teks sub juga
            duration: const Duration(milliseconds: 250),
            child: Text(
              sub,
              key: ValueKey(sub),                       // key sub berubah saat hasMood berubah
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _moodOrder.map((mood) {
        final String emoji    = _moodData[mood]!['emoji'] as String;
        final bool isSelected = _selectedMood == mood;        // true jika ini mood yang aktif

        return GestureDetector(
          onTap: () => _selectMood(mood),
          child: AnimatedContainer(                           // semua perubahan ukuran/warna dianimasikan
            duration: const Duration(milliseconds: 250),     // sedikit lebih cepat dari kartu
            curve: Curves.easeOutBack,                       // efek sedikit overshoot — tombol "pop"
            width:  isSelected ? 68.0 : 56.0,               // tombol aktif lebih besar
            height: isSelected ? 68.0 : 56.0,               // tinggi ikut lebar — tetap persegi
            decoration: BoxDecoration(
              color: isSelected
                  ? Color(_moodData[mood]!['color'] as int)  // warna aksen saat dipilih
                  : Colors.white,
              borderRadius: BorderRadius.circular(           // radius ikut membesar
                isSelected ? 22.0 : 16.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? Color(_moodData[mood]!['color'] as int).withOpacity(0.45)
                      : Colors.black.withOpacity(0.06),
                  blurRadius: isSelected ? 16.0 : 8.0,      // bayangan lebih besar saat aktif
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              emoji,
              style: TextStyle(
                fontSize: isSelected ? 32.0 : 28.0,         // emoji juga ikut membesar — tanpa animasi tween
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}