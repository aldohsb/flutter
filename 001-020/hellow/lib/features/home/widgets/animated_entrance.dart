// lib/features/home/widgets/animated_entrance.dart
// ─────────────────────────────────────────────────────────
// KONSEP UTAMA: Explicit Animation dengan AnimationController
//
// Widget ini adalah "pembungkus" yang membuat child-nya muncul
// dengan efek fade + slide dari bawah saat pertama kali ditampilkan.
//
// Kenapa dipisah jadi widget sendiri?
// → Reusable: bisa dipakai di mana saja, cukup bungkus widget apapun
// → Testable: animasi bisa diuji terpisah dari konten
// ─────────────────────────────────────────────────────────

import 'package:flutter/material.dart';

class AnimatedEntrance extends StatefulWidget {
  const AnimatedEntrance({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    // delay: opsional, untuk stagger animation (animasi berurutan)
    // Duration.zero = default: langsung mulai tanpa jeda
  });

  final Widget child;
  // child: widget apapun yang ingin diberi animasi entrance

  final Duration delay;
  // delay: berapa lama menunggu sebelum animasi dimulai

  @override
  State<AnimatedEntrance> createState() => _AnimatedEntranceState();
}

class _AnimatedEntranceState extends State<AnimatedEntrance>
    with SingleTickerProviderStateMixin {
  // with: keyword untuk mixin di Dart
  // SingleTickerProviderStateMixin: memberi kemampuan State ini
  //   menjadi "ticker provider" untuk satu AnimationController
  // Ticker = mekanisme yang sync animasi dengan frame rate layar (vsync)

  late final AnimationController _controller;
  // AnimationController: otak animasi — mengontrol waktu & nilai (0.0 → 1.0)

  late final Animation<double> _fadeAnimation;
  // Animation<double>: sequence nilai double yang berubah seiring waktu
  // Dipakai untuk opacity (0.0 = transparan, 1.0 = penuh)

  late final Animation<Offset> _slideAnimation;
  // Animation<Offset>: sequence nilai Offset (posisi x,y) seiring waktu
  // Dipakai untuk pergeseran posisi widget

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      // vsync: this → State ini adalah ticker provider-nya
      // vsync mencegah animasi berjalan saat widget tidak terlihat
      // (menghemat CPU/baterai)
      duration: const Duration(milliseconds: 600),
      // Durasi total satu siklus animasi
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      // Tween: mendefinisikan nilai awal (begin) dan akhir (end)
      // Tween<double>: nilai berubah dari 0.0 ke 1.0
      CurvedAnimation(
        parent: _controller,
        // parent: AnimationController yang menggerakkan animasi ini
        curve: Curves.easeOut,
        // Curves.easeOut: cepat di awal, melambat di akhir
        // Terasa natural seperti gerakan di dunia nyata
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      // Mulai dari 30% di bawah posisi aslinya
      // Offset(x, y): x=horizontal, y=vertikal
      // Nilai dalam satuan "fraction of widget size" bukan pixel
      end: Offset.zero,
      // Offset.zero = Offset(0, 0) = posisi asli
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
        // easeOutCubic: lebih dramatis dari easeOut
        // Slide terasa "landing" yang elegan
      ),
    );

    _startAfterDelay();
    // Mulai animasi, dengan delay jika ada
  }

  Future<void> _startAfterDelay() async {
    if (widget.delay != Duration.zero) {
      await Future.delayed(widget.delay);
      // Future.delayed: tunggu sejumlah waktu tanpa memblok UI
    }

    if (mounted) _controller.forward();
    // forward(): jalankan animasi dari nilai awal (0.0) ke akhir (1.0)
    // mounted check: pastikan widget masih ada setelah Future.delayed
  }

  @override
  void dispose() {
    _controller.dispose();
    // AnimationController WAJIB di-dispose untuk menghentikan ticker
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      // FadeTransition: widget yang mengubah opacity berdasarkan Animation
      // Lebih efisien dari AnimatedOpacity karena tidak rebuild widget tree
      opacity: _fadeAnimation,
      child: SlideTransition(
        // SlideTransition: widget yang menggeser posisi berdasarkan Animation
        // Juga lebih efisien karena bekerja di layer kompositor, bukan rebuild
        position: _slideAnimation,
        child: widget.child,
        // widget.child: akses ke parameter child dari StatefulWidget
      ),
    );
  }
}