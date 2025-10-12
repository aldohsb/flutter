import 'package:flutter/material.dart';
import '../theme/app_text_styles.dart';

/// Widget custom untuk menampilkan text dengan efek neon glow
/// 
/// StatelessWidget karena text tidak perlu state management
/// Widget ini reusable dan bisa dikonfigurasi dengan parameter
class NeonText extends StatelessWidget {
  /// Text yang akan ditampilkan
  final String text;
  
  /// Style text (opsional, ada default)
  final TextStyle? style;
  
  /// Text alignment (opsional)
  final TextAlign? textAlign;

  /// Constructor dengan parameter yang bisa dikustomisasi
  /// 
  /// this.text adalah required parameter (wajib)
  /// this.style dan this.textAlign adalah optional parameter
  const NeonText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    // Text: widget dasar untuk menampilkan text
    return Text(
      text,
      
      // style: menggabungkan default style dengan custom style
      // ?? operator: jika style null, gunakan neonHeading
      style: style ?? AppTextStyles.neonHeading,
      
      // textAlign: alignment horizontal text
      textAlign: textAlign ?? TextAlign.center,
      
      // textScaleFactor: 1.0 = ukuran normal (tidak terpengaruh accessibility scaling)
      // Bisa dihapus jika ingin support accessibility text scaling
      textScaler: const TextScaler.linear(1.0),
    );
  }
}

/// Widget untuk menampilkan text dengan gradient warna
/// Menggunakan ShaderMask untuk apply gradient ke text
class GradientNeonText extends StatelessWidget {
  /// Text yang akan ditampilkan
  final String text;
  
  /// Gradient yang akan diapply
  final Gradient gradient;
  
  /// Text style
  final TextStyle? style;
  
  /// Text alignment
  final TextAlign? textAlign;

  /// Constructor
  const GradientNeonText({
    super.key,
    required this.text,
    required this.gradient,
    this.style,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    // ShaderMask: widget untuk apply shader (gradient) ke child widget
    return ShaderMask(
      // shaderCallback: function yang return shader
      // bounds adalah rectangle area dari child widget
      shaderCallback: (Rect bounds) {
        // createShader: membuat shader dari gradient
        return gradient.createShader(bounds);
      },
      
      // blendMode: cara gradient di-blend dengan widget
      // BlendMode.srcIn: gradient hanya muncul di area widget
      blendMode: BlendMode.srcIn,
      
      child: Text(
        text,
        style: style ?? AppTextStyles.neonHeading,
        textAlign: textAlign ?? TextAlign.center,
        textScaler: const TextScaler.linear(1.0),
      ),
    );
  }
}

/// Widget untuk menampilkan pulsing/animated neon text
/// Menggunakan AnimatedOpacity untuk efek berkedip subtle
class PulsingNeonText extends StatefulWidget {
  /// Text yang akan ditampilkan
  final String text;
  
  /// Text style
  final TextStyle? style;
  
  /// Durasi animasi
  final Duration duration;

  /// Constructor
  const PulsingNeonText({
    super.key,
    required this.text,
    this.style,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<PulsingNeonText> createState() => _PulsingNeonTextState();
}

/// State untuk PulsingNeonText
/// Menggunakan SingleTickerProviderStateMixin untuk animation controller
class _PulsingNeonTextState extends State<PulsingNeonText>
    with SingleTickerProviderStateMixin {
  /// Animation controller untuk mengatur animasi
  late AnimationController _controller;
  
  /// Animation untuk nilai opacity
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    // Inisialisasi animation controller
    _controller = AnimationController(
      // vsync: this (dari SingleTickerProviderStateMixin)
      vsync: this,
      // duration: durasi satu cycle animasi
      duration: widget.duration,
    );

    // Membuat tween animation dari 0.6 ke 1.0 (opacity)
    _animation = Tween<double>(
      begin: 0.6,  // Opacity minimum
      end: 1.0,    // Opacity maximum
    ).animate(
      // CurvedAnimation: memberi efek easing pada animasi
      CurvedAnimation(
        parent: _controller,
        // Curves.easeInOut: smooth acceleration dan deceleration
        curve: Curves.easeInOut,
      ),
    );

    // Menjalankan animasi berulang (reverse setelah complete)
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    // Dispose controller saat widget dihapus untuk free memory
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // AnimatedBuilder: rebuild widget setiap kali animation berubah
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          // opacity dari animation value
          opacity: _animation.value,
          child: child,
        );
      },
      // child: widget yang akan di-animate
      child: Text(
        widget.text,
        style: widget.style ?? AppTextStyles.neonHeading,
        textAlign: TextAlign.center,
        textScaler: const TextScaler.linear(1.0),
      ),
    );
  }
}