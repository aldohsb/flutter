import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utils/app_constants.dart';

/// Menampilkan tujuh opsi jawaban skala Likert sebagai daftar tombol pilihan
/// yang dapat ditekan, dengan indikasi visual yang jelas saat dipilih.
///
/// Opsi ke-4 ("Netral / Tergantung Situasi") diberi tampilan berbeda —
/// warna lebih redup dan label kecil peringatan — untuk secara halus
/// mendorong responden memilih jawaban yang lebih definitif jika memungkinkan.
class LikertSelector extends StatelessWidget {
  const LikertSelector({
    super.key,
    required this.selectedValue,
    required this.onChanged,
  });

  final int? selectedValue;
  final ValueChanged<int> onChanged;

  /// Indeks ke-3 (value=4) adalah opsi netral di skala 1-7.
  static const int _neutralValue = 4;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(AppConstants.likertValues.length, (index) {
          final value = AppConstants.likertValues[index];
          final label = AppConstants.likertLabels[index];
          final isSelected = selectedValue == value;
          final isNeutral = value == _neutralValue;

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _LikertOptionTile(
              value: value,
              label: label,
              isSelected: isSelected,
              isNeutral: isNeutral,
              onTap: () => onChanged(value),
            ),
          );
        }),

        // Peringatan netral — hanya muncul saat opsi netral dipilih
        if (selectedValue == _neutralValue)
          const Padding(
            padding: EdgeInsets.only(top: 2, left: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 14,
                  color: AppColors.textMuted,
                ),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    AppConstants.neutralWarning,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _LikertOptionTile extends StatelessWidget {
  const _LikertOptionTile({
    required this.value,
    required this.label,
    required this.isSelected,
    required this.isNeutral,
    required this.onTap,
  });

  final int value;
  final String label;
  final bool isSelected;
  final bool isNeutral;
  final VoidCallback onTap;

  /// Warna aksen berdasarkan arah jawaban:
  /// 1-3 = merah/oranye (tidak setuju), 4 = abu (netral), 5-7 = hijau/biru (setuju)
  Color get _accentColor {
    if (value <= 3) {
      return Color.lerp(
        const Color(0xFFDC2626),
        const Color(0xFFF97316),
        (value - 1) / 2,
      )!;
    }
    if (value == 4) return AppColors.textMuted;
    return Color.lerp(
      const Color(0xFF3B82F6),
      const Color(0xFF059669),
      (value - 5) / 2,
    )!;
  }

  @override
  Widget build(BuildContext context) {
    final accent = _accentColor;

    return Material(
      color: isSelected
          ? accent.withValues(alpha: isNeutral ? 0.05 : 0.08)
          : AppColors.surface,
      borderRadius: BorderRadius.circular(13),
      child: InkWell(
        borderRadius: BorderRadius.circular(13),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              color: isSelected ? accent : AppColors.border,
              width: isSelected ? 1.8 : 1.2,
            ),
          ),
          child: Row(
            children: [
              // Radio circle dengan warna aksen arah jawaban
              AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? accent : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? accent : AppColors.border,
                    width: 1.8,
                  ),
                ),
                child: isSelected
                    ? const Icon(Icons.check, size: 12, color: Colors.white)
                    : null,
              ),
              const SizedBox(width: 12),

              // Label
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: isNeutral ? 13.5 : 14.5,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected
                        ? (isNeutral ? AppColors.textSecondary : AppColors.textPrimary)
                        : (isNeutral ? AppColors.textMuted : AppColors.textSecondary),
                    fontStyle: isNeutral ? FontStyle.italic : FontStyle.normal,
                  ),
                ),
              ),

              // Nomor skala (subtle, di kanan)
              Text(
                value.toString(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? accent : AppColors.border,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}