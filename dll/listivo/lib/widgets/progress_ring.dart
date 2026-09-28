// lib/widgets/progress_ring.dart
// Widget custom: lingkaran progres harian dengan warna dinamis yang animatif
// Ini adalah elemen "out of the box" pembeda Listivo dari to-do app biasa

import 'package:flutter/material.dart'; // AnimationController, CircularProgressIndicator
import '../theme/app_colors.dart'; // palet warna calm -> seed -> celebrate
import '../constants/app_constants.dart'; // durasi animasi standar

class ProgressRing extends StatefulWidget {
  // Nilai progres saat ini, dikirim dari HomeScreen (0.0 sampai 1.0)
  final double progress;

  // Jumlah tugas selesai, ditampilkan sebagai teks di tengah ring
  final int done;

  // Jumlah total tugas, ditampilkan sebagai pembanding di tengah ring
  final int total;

  const ProgressRing({
    super.key,
    required this.progress,
    required this.done,
    required this.total,
  });

  @override
  State<ProgressRing> createState() => _ProgressRingState();
}

// SingleTickerProviderStateMixin dibutuhkan agar State ini bisa jadi vsync animasi
class _ProgressRingState extends State<ProgressRing>
    with SingleTickerProviderStateMixin {
  // Controller yang mengatur jalannya animasi dari 0.0 sampai 1.0 setiap kali dipicu
  late final AnimationController _controller;

  // Animation bertipe double yang nilainya dipakai untuk menggambar ring
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Controller dibuat sekali di awal dengan durasi animasi medium
    _controller = AnimationController(
      vsync: this,
      duration: AppConstants.animationMedium,
    );
    // Animasi pertama kali: dari 0 menuju nilai progress awal
    _animation = Tween<double>(begin: 0, end: widget.progress).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.forward(); // langsung mainkan animasi saat widget pertama muncul
  }

  @override
  void didUpdateWidget(covariant ProgressRing oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Jika nilai progress berubah dari parent, animasikan dari nilai lama ke baru
    if (oldWidget.progress != widget.progress) {
      _animation = Tween<double>(
        begin: oldWidget.progress,
        end: widget.progress,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
      _controller.forward(from: 0); // mulai ulang animasi dari awal durasi
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // wajib dispose controller agar tidak memory leak
    super.dispose();
  }

  // Algoritma interpolasi warna 2 segmen: calm -> seed (0-50%), seed -> celebrate (50-100%)
  Color _ringColor(double progress) {
    if (progress < 0.5) {
      final t = progress / 0.5; // normalisasi segmen pertama ke rentang 0..1
      return Color.lerp(AppColors.calm, AppColors.seed, t)!;
    } else {
      final t = (progress - 0.5) / 0.5; // normalisasi segmen kedua ke rentang 0..1
      return Color.lerp(AppColors.seed, AppColors.celebrate, t)!;
    }
  }

  @override
  Widget build(BuildContext context) {
    // AnimatedBuilder membangun ulang UI setiap frame animasi berjalan
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final value = _animation.value; // nilai progres pada frame saat ini
        final ringColor = _ringColor(value); // warna ring mengikuti nilai frame ini

        return Stack(
          alignment: Alignment.center, // menumpuk ring dan teks di titik tengah
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: CircularProgressIndicator(
                value: value, // posisi lingkaran progres saat ini
                strokeWidth: 10, // ketebalan garis ring
                strokeCap: StrokeCap.round, // ujung garis membulat, kesan lembut
                backgroundColor: ringColor.withValues(alpha: 0.15), // trek belakang
                valueColor: AlwaysStoppedAnimation<Color>(ringColor), // warna aktif
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min, // kolom hanya setinggi isinya
              children: [
                Text(
                  '${(value * 100).round()}%', // persentase dibulatkan tanpa desimal
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  '${widget.done}/${widget.total} tugas', // pecahan tugas selesai
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.neutral,
                      ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}