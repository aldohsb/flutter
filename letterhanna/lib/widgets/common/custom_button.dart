import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

// Enum untuk tipe button
enum ButtonType {
  primary,    // Filled button dengan gradient
  outlined,   // Outline button
  text,       // Text button tanpa background
}

// CustomButton adalah widget reusable untuk button
// Kita buat sekali, pakai berkali-kali dengan style konsisten
class CustomButton extends StatelessWidget {
  // Properties yang bisa di-customize
  final String text;              // Text di button
  final VoidCallback onPressed;   // Function saat button di-tap
  final ButtonType type;          // Tipe button (primary, outlined, text)
  final bool isLoading;           // Tampilkan loading indicator?
  final bool isDisabled;          // Button disabled?
  final double? width;            // Lebar button (null = wrap content)
  final IconData? icon;           // Icon di kiri text (optional)

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.isDisabled = false,
    this.width,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // Jika disabled atau loading, onPressed jadi null (otomatis disabled)
    final effectiveOnPressed = (isDisabled || isLoading) ? null : onPressed;

    // Switch berdasarkan tipe button
    switch (type) {
      case ButtonType.primary:
        return _buildPrimaryButton(context, effectiveOnPressed);
      case ButtonType.outlined:
        return _buildOutlinedButton(context, effectiveOnPressed);
      case ButtonType.text:
        return _buildTextButton(context, effectiveOnPressed);
    }
  }

  // === PRIMARY BUTTON (Gradient Background) ===
  Widget _buildPrimaryButton(BuildContext context, VoidCallback? onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          // Gradient background
          gradient: onPressed != null
              ? LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primaryLight,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          
          // Jika disabled, pakai warna abu-abu
          color: onPressed == null ? AppColors.textHint : null,
          
          borderRadius: BorderRadius.circular(30),
          
          // Shadow
          boxShadow: onPressed != null
              ? [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: _buildButtonContent(context, true),
      ),
    );
  }

  // === OUTLINED BUTTON ===
  Widget _buildOutlinedButton(BuildContext context, VoidCallback? onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: onPressed != null ? AppColors.primary : AppColors.textHint,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: _buildButtonContent(context, false),
      ),
    );
  }

  // === TEXT BUTTON ===
  Widget _buildTextButton(BuildContext context, VoidCallback? onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        child: _buildButtonContent(context, false),
      ),
    );
  }

  // === BUTTON CONTENT (Text + Icon + Loading) ===
  Widget _buildButtonContent(BuildContext context, bool isPrimary) {
    // Tentukan warna text berdasarkan tipe button dan state
    Color textColor;
    if (isDisabled || isLoading) {
      textColor = AppColors.textHint;
    } else if (isPrimary) {
      textColor = AppColors.textOnDark;
    } else {
      textColor = AppColors.primary;
    }

    return Row(
      mainAxisSize: MainAxisSize.min, // Wrap content
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Loading indicator
        if (isLoading)
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(textColor),
            ),
          ),
        
        // Icon (jika ada dan tidak loading)
        if (!isLoading && icon != null) ...[
          Icon(
            icon,
            size: 20,
            color: textColor,
          ),
          const SizedBox(width: 8),
        ],
        
        // Spacing jika loading
        if (isLoading) const SizedBox(width: 12),
        
        // Button text
        Text(
          isLoading ? 'Loading...' : text,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: textColor,
                letterSpacing: 1.2,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}