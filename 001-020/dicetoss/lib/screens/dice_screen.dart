// ============================================================
// screens/dice_screen.dart
// Menyimpan state dadu, mengelola animasi, dan merender UI.
// ============================================================

import 'package:flutter/material.dart';
import '../models/die.dart';
import '../widgets/die_face.dart';

class DiceScreen extends StatefulWidget {
  const DiceScreen({super.key});

  @override
  State<DiceScreen> createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen>
    with SingleTickerProviderStateMixin {
  // Objek dadu — nilai awalnya 1.
  Die _die = Die();

  // Total lemparan sejak app dibuka.
  int _rollCount = 0;

  // Histogram: berapa kali tiap angka (1–6) muncul.
  // Diinisialisasi dengan 0 untuk semua key agar tidak perlu null-check.
  final Map<int, int> _tally = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0};

  // AnimationController untuk animasi goyang (shake) tombol lempar.
  // SingleTickerProviderStateMixin menyediakan vsync yang dibutuhkan controller.
  late AnimationController _shakeController;

  // Animasi offset horizontal — dadu "goyang" kiri-kanan saat dilempar.
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();

    // Controller shake: durasi singkat 400ms — terasa seperti lempar cepat.
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,                     // this = State sendiri, berkat mixin
    );

    // TweenSequence: animasi multi-langkah dalam satu Animation.
    // Dadu bergerak kanan → kiri → kanan → kiri → kembali ke tengah.
    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 10), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 10, end: -10), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -10, end: 10), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 10, end: -8), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -8, end: 0), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _shakeController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    // Wajib dispose controller agar tidak memory leak.
    _shakeController.dispose();
    super.dispose();
  }

  // Lempar dadu: update state, jalankan animasi shake.
  void _rollDie() {
    // Jalankan animasi dari awal (forward dari posisi 0).
    _shakeController.forward(from: 0);

    setState(() {
      _die.roll();                         // acak nilai dadu
      _rollCount++;                        // tambah counter total
      _tally[_die.value] = (_tally[_die.value] ?? 0) + 1; // tambah tally angka ini
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildDieArea(),
            _buildRollButton(),
            const SizedBox(height: 20),
            _buildTallySection(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // ─── HEADER ─────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'dicetoss',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              Text(
                'Lempar: $_rollCount kali',
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF888899),
                ),
              ),
            ],
          ),

          // Tombol reset — hanya tampil jika sudah pernah lempar.
          if (_rollCount > 0)
            TextButton.icon(
              onPressed: _resetAll,
              icon: const Icon(Icons.refresh_rounded, size: 16),
              label: const Text('Reset'),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF888899),
                textStyle: const TextStyle(fontSize: 13),
              ),
            ),
        ],
      ),
    );
  }

  // ─── DIE AREA ───────────────────────────────────────────────────────────────

  Widget _buildDieArea() {
    return Expanded(
      child: Center(

        // AnimatedBuilder mendengarkan _shakeAnimation dan rebuild
        // setiap frame saat animasi berjalan.
        child: AnimatedBuilder(
          animation: _shakeAnimation,
          builder: (context, child) {
            return Transform.translate(

              // Geser dadu secara horizontal sesuai nilai animasi.
              offset: Offset(_shakeAnimation.value, 0),
              child: child,
            );
          },

          // AnimatedSwitcher di dalam child AnimatedBuilder.
          // child hanya dibangun sekali, bukan tiap frame — efisien.
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),

            // switchInCurve: kurva untuk widget baru masuk.
            switchInCurve: Curves.easeOut,

            // transitionBuilder: kustomisasi animasi masuk/keluar.
            // Default AnimatedSwitcher adalah FadeTransition.
            // Di sini dikombinasikan Scale + Fade.
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: Tween<double>(begin: 0.6, end: 1.0).animate(animation),
                child: FadeTransition(opacity: animation, child: child),
              );
            },

            // ValueKey wajib ada agar AnimatedSwitcher tahu
            // bahwa widget berubah saat nilai dadu berubah.
            child: DieFace(
              key: ValueKey(_die.value),
              value: _die.value,
            ),
          ),
        ),
      ),
    );
  }

  // ─── ROLL BUTTON ────────────────────────────────────────────────────────────

  Widget _buildRollButton() {
    return GestureDetector(
      onTap: _rollDie,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1A1A2E).withOpacity(0.30),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.casino_rounded, color: Colors.white, size: 20),
            SizedBox(width: 10),
            Text(
              'Lempar Dadu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── TALLY SECTION ──────────────────────────────────────────────────────────

  Widget _buildTallySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hasil lemparan',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF888899),
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Buat kolom tally untuk angka 1 sampai 6.
              for (int i = 1; i <= 6; i++) _buildTallyColumn(i),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTallyColumn(int faceValue) {
    final int count = _tally[faceValue] ?? 0;

    // Hitung tinggi bar proporsional terhadap tally tertinggi.
    // Jika semua 0 (belum lempar), maxCount = 1 agar tidak bagi nol.
    final int maxCount = _tally.values.reduce((a, b) => a > b ? a : b);
    final double barHeight = maxCount == 0
        ? 0
        : (count / maxCount) * 48;    // tinggi maksimal bar = 48px

    // Warna dari DieFace — ambil dari Map yang sama.
    const Map<int, Color> colors = {
      1: Color(0xFFE53935),
      2: Color(0xFFE91E63),
      3: Color(0xFF8E24AA),
      4: Color(0xFF1E88E5),
      5: Color(0xFF00ACC1),
      6: Color(0xFF43A047),
    };
    final Color barColor = colors[faceValue]!;

    return Column(
      children: [
        // Jumlah lemparan angka ini — animasi saat berubah.
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Text(
            '$count',
            key: ValueKey(count),       // key berubah → fade animasi
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: count > 0 ? barColor : const Color(0xFFCCCCDD),
            ),
          ),
        ),
        const SizedBox(height: 4),

        // Bar tally — tingginya berubah sesuai jumlah kemunculan.
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          width: 32,
          height: barHeight.clamp(0, 48),   // pastikan tidak negatif atau overflow
          decoration: BoxDecoration(
            color: count > 0
                ? barColor.withOpacity(0.75)
                : const Color(0xFFEEEEF5),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 6),

        // Label angka di bawah bar.
        Text(
          '$faceValue',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: count > 0 ? barColor : const Color(0xFFBBBBCC),
          ),
        ),
      ],
    );
  }

  // ─── RESET ──────────────────────────────────────────────────────────────────

  void _resetAll() {
    setState(() {
      _die = Die();                        // dadu kembali ke nilai 1
      _rollCount = 0;
      _tally.updateAll((key, value) => 0); // set semua tally ke 0
    });
  }
}