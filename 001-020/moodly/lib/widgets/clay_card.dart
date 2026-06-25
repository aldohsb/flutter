// lib/widgets/clay_card.dart
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

// ClayCard adalah wrapper dekoratif — membungkus child apapun
// dengan tampilan "clay" tanpa harus menulis BoxDecoration berulang
class ClayCard extends StatelessWidget {
  // Widget apapun yang ingin dibungkus dengan gaya clay
  final Widget child;

  // Warna permukaan kartu
  final Color color;

  // Warna shadow bawah (efek 3D clay)
  final Color shadowColor;

  // Padding di dalam kartu antara tepi dan konten
  final EdgeInsetsGeometry padding;

  // Ukuran sudut melengkung
  final double borderRadius;

  // Apakah kartu punya border outline?
  final bool hasBorder;

  // Callback opsional — jika diisi, kartu bisa ditekan
  final VoidCallback? onTap;

  const ClayCard({
    super.key,
    required this.child,
    this.color = AppColors.surface,
    this.shadowColor = AppColors.cardShadow,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 20,
    this.hasBorder = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: padding,

      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        // BorderRadius.circular = semua sudut melengkung dengan radius sama

        border: hasBorder
            ? Border.all(color: AppColors.border, width: 1.5)
            : null,
        // Border outline tipis memberi definisi tepi — khas claymorphism

        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: const Offset(0, 4),
            // offset(0,4) = shadow di bawah → kesan kartu "mengambang"
            blurRadius: 12,
            // blurRadius 12 = shadow halus (beda dengan clay button yang 0)
            // Kartu tidak ditekan → shadow lebih lembut dari tombol
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.9),
            offset: const Offset(0, -1),
            // Highlight atas tipis → efek cahaya dari atas
            blurRadius: 4,
          ),
        ],
      ),

      child: child,
    );

    if (onTap == null) return card;
    // Jika tidak ada onTap, langsung return card tanpa gesture detector

    return Material(
      color: Colors.transparent,
      // Material dengan warna transparan diperlukan untuk InkWell
      // agar efek ripple muncul DI ATAS kartu, bukan di belakangnya

      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        // borderRadius InkWell harus sama dengan borderRadius kartu
        // agar efek ripple tidak meluber keluar sudut melengkung
        splashColor: color.withOpacity(0.3),
        highlightColor: color.withOpacity(0.1),
        child: card,
      ),
    );
  }
}

// ============================================================
// ClayCardSm — varian kecil tanpa padding bawaan
// Berguna untuk chip atau badge kecil bergaya clay
// ============================================================
class ClayChip extends StatelessWidget {
  final String label;
  final Color color;
  final Color shadowColor;
  final Widget? leading;
  // Widget opsional di kiri label (biasanya ikon atau emoji)

  const ClayChip({
    super.key,
    required this.label,
    required this.color,
    required this.shadowColor,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),

      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
        // borderRadius 50 (atau lebih) = bentuk "pill" / kapsul

        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: const Offset(0, 4),
            blurRadius: 0,
            // Clay chip punya shadow tegas (blur 0) seperti clay button
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.85),
            offset: const Offset(0, -1),
            blurRadius: 3,
          ),
        ],
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[
            leading!,
            // '!' setelah leading karena kita sudah cek leading != null di atas
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: AppColors.textOnClay,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// ClayContainer — clay tanpa padding default
// Untuk kebutuhan layout yang lebih fleksibel
// ============================================================
class ClayContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final Color shadowColor;
  final double borderRadius;
  final double shadowDepth;
  // Seberapa "dalam" efek 3D clay-nya (offset shadow)

  const ClayContainer({
    super.key,
    required this.child,
    required this.color,
    required this.shadowColor,
    this.borderRadius = 20,
    this.shadowDepth = 6,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      // DecoratedBox lebih ringan dari Container jika tidak butuh padding/size
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: Offset(0, shadowDepth),
            // Depth bisa dikustomisasi — makin besar = makin "tebal" clay-nya
            blurRadius: 0,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            offset: const Offset(0, -2),
            blurRadius: 5,
          ),
        ],
      ),
      child: child,
    );
  }
}