import 'package:flutter/material.dart';
import '../models/mood_model.dart';
import '../utils/color_generator.dart';

/// Widget tombol mood dengan efek explode warna random
/// Ini adalah StatefulWidget karena warna berubah ketika di-tap
class MoodButton extends StatefulWidget {
  // Data mood yang akan ditampilkan
  final MoodModel mood;
  
  // Callback function ketika button di-tap
  final VoidCallback onTap;

  // Constructor
  const MoodButton({
    super.key,
    required this.mood,
    required this.onTap,
  });

  @override
  State<MoodButton> createState() => _MoodButtonState();
}

/// State class untuk MoodButton
/// Di sini kita manage lifecycle dan state changes
class _MoodButtonState extends State<MoodButton> 
    with SingleTickerProviderStateMixin {
  
  // State variables
  late List<Color> _gradientColors; // Warna gradient untuk button
  late AnimationController _controller; // Controller untuk animation
  late Animation<double> _scaleAnimation; // Animation untuk scale effect

  /// initState() - Lifecycle method yang dipanggil PERTAMA KALI
  /// ketika widget dibuat. Hanya dipanggil SATU KALI.
  /// Digunakan untuk:
  /// - Inisialisasi state awal
  /// - Setup animation controllers
  /// - Subscribe ke streams
  /// - Load data awal
  @override
  void initState() {
    super.initState(); // WAJIB dipanggil first
    
    // Inisialisasi gradient colors pertama kali
    _gradientColors = ColorGenerator.generateGradientColors();
    
    // Setup animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200), // Durasi animation
      vsync: this, // Sinkronisasi dengan screen refresh rate
    );
    
    // Setup scale animation dengan Tween
    // Tween define nilai awal (1.0) dan akhir (0.9)
    _scaleAnimation = Tween<double>(
      begin: 1.0, // Scale normal
      end: 0.9,   // Scale mengecil saat pressed
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Kurva animation smooth
      ),
    );
  }

  /// dispose() - Lifecycle method yang dipanggil ketika widget dihapus
  /// WAJIB dispose AnimationController dan resource lain untuk avoid memory leak
  @override
  void dispose() {
    _controller.dispose(); // Cleanup animation controller
    super.dispose();
  }

  /// Method untuk handle tap event
  /// Di sini kita update state dengan setState()
  void _handleTap() {
    // setState() - Method untuk update state dan trigger rebuild
    // SEMUA perubahan state HARUS di dalam setState()
    // Flutter akan rebuild widget tree setelah setState() selesai
    setState(() {
      // Generate warna gradient baru setiap tap
      _gradientColors = ColorGenerator.generateGradientColors();
    });
    
    // Trigger scale animation
    _controller.forward().then((_) {
      _controller.reverse(); // Kembali ke scale normal
    });
    
    // Panggil callback dari parent
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    // AnimatedBuilder untuk rebuild hanya bagian yang perlu animation
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          
          child: GestureDetector(
            // onTap - Callback yang dipanggil ketika user tap widget
            // Ini adalah cara Flutter mendeteksi user interaction
            onTap: _handleTap,
            
            // onTapDown - Ketika user mulai press (untuk feedback immediate)
            onTapDown: (_) {
              setState(() {
                // Bisa tambah efek visual saat pressed
              });
            },
            
            child: Container(
              // Sizing
              width: 160,
              height: 160,
              
              // Decoration untuk liquid morphism style
              decoration: BoxDecoration(
                // Gradient linear untuk warna yang smooth
                gradient: LinearGradient(
                  // Gradient dari kiri atas ke kanan bawah
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: _gradientColors,
                ),
                
                // Border radius besar untuk blob shape
                borderRadius: BorderRadius.circular(40),
                
                // Box shadow untuk depth dan premium look
                boxShadow: [
                  BoxShadow(
                    color: _gradientColors[0].withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: _gradientColors[1].withOpacity(0.2),
                    blurRadius: 40,
                    spreadRadius: 5,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              
              // Content dalam button
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Emoji
                  Text(
                    widget.mood.emoji,
                    style: const TextStyle(
                      fontSize: 56,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Label mood
                  Text(
                    widget.mood.label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}