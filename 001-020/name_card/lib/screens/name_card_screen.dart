import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_colors.dart';
import '../widgets/info_row_widget.dart';
import '../widgets/social_icon_widget.dart';

class NameCardScreen extends StatelessWidget {
  const NameCardScreen({super.key});

  static const String _nama = 'Aldo Setiawan';
  static const String _jabatan = 'Font Designer & Flutter Developer';
  static const String _perusahaan = 'Letterhanna Studio';
  static const String _telepon = '+62 812 3456 7890';
  static const String _email = 'aldo@letterhanna.com';
  static const String _website = 'letterhanna.com';
  static const String _kota = 'Yogyakarta, Indonesia';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 32),
              _buildSectionTitle('Informasi Kontak'),
              const SizedBox(height: 12),
              _buildContactCard(),
              const SizedBox(height: 28),
              _buildSectionTitle('Media Sosial'),
              const SizedBox(height: 16),
              _buildSocialMedia(),
              const SizedBox(height: 28),
              _buildSectionTitle('Statistik'),
              const SizedBox(height: 12),
              _buildStats(),
              const SizedBox(height: 32),
              _buildTagline(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.backgroundCard, AppColors.backgroundSurface],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryGlow,
            blurRadius: 30,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 20,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: AppColors.primary, width: 2),
                ),
                child: const Center(
                  child: Text(
                    'AS',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.accentTeal.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.accentTeal.withValues(alpha: 0.4),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.accentTeal,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Available',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.accentTeal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            _nama,
            style: GoogleFonts.poppins(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _jabatan,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.business, size: 13, color: AppColors.primary),
                const SizedBox(width: 6),
                const Text(
                  _perusahaan,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 18,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildContactCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider, width: 1),
      ),
      child: Column(
        children: [
          InfoRowWidget(
            icon: Icons.phone_outlined,
            label: 'Telepon',
            value: _telepon,
            iconColor: AppColors.accentTeal,
          ),
          _buildDivider(),
          InfoRowWidget(
            icon: Icons.email_outlined,
            label: 'Email',
            value: _email,
            iconColor: AppColors.primary,
          ),
          _buildDivider(),
          InfoRowWidget(
            icon: Icons.language_outlined,
            label: 'Website',
            value: _website,
            iconColor: AppColors.accentAmber,
          ),
          _buildDivider(),
          InfoRowWidget(
            icon: Icons.location_on_outlined,
            label: 'Lokasi',
            value: _kota,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1, color: AppColors.divider);
  }

  Widget _buildSocialMedia() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SocialIconWidget(
          icon: Icons.camera_alt_outlined,
          platform: 'Instagram',
          color: const Color(0xFFE1306C),
        ),
        const SizedBox(width: 12),
        SocialIconWidget(
          icon: Icons.design_services_outlined,
          platform: 'Behance',
          color: const Color(0xFF1769FF),
        ),
        const SizedBox(width: 12),
        SocialIconWidget(
          icon: Icons.store_outlined,
          platform: 'Gumroad',
          color: const Color(0xFFFF90E8),
        ),
        const SizedBox(width: 12),
        SocialIconWidget(
          icon: Icons.font_download_outlined,
          platform: 'Creative Market',
          color: const Color(0xFF8BA7A7),
        ),
      ],
    );
  }

  Widget _buildStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatItem(
            value: '75+',
            label: 'Font\nDirilis',
            icon: Icons.font_download,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatItem(
            value: '5',
            label: 'Tahun\nPengalaman',
            icon: Icons.workspace_premium,
            color: AppColors.accentAmber,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatItem(
            value: '6',
            label: 'Platform\nPenjualan',
            icon: Icons.storefront,
            color: AppColors.accentTeal,
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required String value,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 10),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              height: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textMuted,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagline() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.08),
            AppColors.primaryDark.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.format_quote, color: AppColors.primary, size: 20),
          const SizedBox(height: 8),
          Text(
            'Type is the voice of the written word. Every font tells a story — I craft that story.',
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}