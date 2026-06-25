// lib/main.dart (Part 6 update)
// Showcase semua clay widget yang baru dibuat.
// Tidak ada Provider di sini — kita fokus pada tampilan widget.
import 'package:flutter/material.dart';

import 'package:moodly/theme/app_theme.dart';
import 'package:moodly/theme/app_colors.dart';
import 'package:moodly/theme/app_text_styles.dart';

// Import widget clay yang baru dibuat
import 'package:moodly/widgets/clay_button.dart';
import 'package:moodly/widgets/clay_card.dart';

void main() {
  runApp(const MoodlyApp());
}

class MoodlyApp extends StatelessWidget {
  const MoodlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moodly',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const ClayShowcaseScreen(),
    );
  }
}

class ClayShowcaseScreen extends StatefulWidget {
  const ClayShowcaseScreen({super.key});

  @override
  State<ClayShowcaseScreen> createState() => _ClayShowcaseScreenState();
}

class _ClayShowcaseScreenState extends State<ClayShowcaseScreen> {
  bool _isLoading = false;
  String _lastTapped = '(belum ada)';

  void _simulateLoading() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    // Future.delayed = tunggu N durasi tanpa melakukan apa-apa (simulasi proses)
    setState(() {
      _isLoading = false;
      _lastTapped = 'Loading button';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎨 Part 6 – Clay Widgets'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ================================================
            // SECTION 1: ClayButton variants
            // ================================================
            Text('ClayButton – Semua Varian', style: AppTextStyles.headlineLarge),
            const SizedBox(height: 16),

            // Tombol pink penuh - ukuran full width
            ClayButton(
              label: 'Simpan Mood Hari Ini',
              icon: Icons.favorite_rounded,
              color: AppColors.pink,
              shadowColor: AppColors.pinkShadow,
              width: double.infinity,
              onPressed: () => setState(() => _lastTapped = 'Pink full-width'),
            ),
            const SizedBox(height: 12),

            // Baris dua tombol berdampingan
            Row(
              children: [
                Expanded(
                  child: ClayButton(
                    label: 'Lihat Chart',
                    icon: Icons.bar_chart_rounded,
                    color: AppColors.lavender,
                    shadowColor: AppColors.lavenderShadow,
                    onPressed: () => setState(() => _lastTapped = 'Lavender'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ClayButton(
                    label: 'Riwayat',
                    icon: Icons.history_rounded,
                    color: AppColors.mint,
                    shadowColor: AppColors.mintShadow,
                    onPressed: () => setState(() => _lastTapped = 'Mint'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Tombol dengan state loading
            ClayButton(
              label: _isLoading ? 'Menyimpan...' : 'Simulasi Loading',
              icon: Icons.sync_rounded,
              color: AppColors.peach,
              shadowColor: AppColors.peachShadow,
              width: double.infinity,
              isLoading: _isLoading,
              onPressed: _simulateLoading,
            ),
            const SizedBox(height: 12),

            // Tombol nonaktif (disabled) — onPressed: null
            ClayButton(
              label: 'Tombol Nonaktif',
              color: AppColors.pink,
              shadowColor: AppColors.pinkShadow,
              width: double.infinity,
              onPressed: null,
              // onPressed null = tombol abu-abu & tidak merespons tap
            ),

            const SizedBox(height: 8),
            // Feedback teks yang terakhir ditekan
            Center(
              child: Text(
                'Terakhir ditekan: $_lastTapped',
                style: AppTextStyles.bodySmall,
              ),
            ),

            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 24),

            // ================================================
            // SECTION 2: ClayCard
            // ================================================
            Text('ClayCard – Container Fleksibel', style: AppTextStyles.headlineLarge),
            const SizedBox(height: 16),

            // ClayCard biasa dengan konten
            ClayCard(
              color: AppColors.surfaceSecondary,
              shadowColor: AppColors.cardShadow,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('😊 Senang', style: AppTextStyles.headlineMedium),
                  const SizedBox(height: 4),
                  Text('Hari ini terasa menyenangkan sekali.',
                      style: AppTextStyles.bodyMedium),
                  const SizedBox(height: 8),
                  Text('Senin, 23 Juni 2026 · 08:30',
                      style: AppTextStyles.bodySmall),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ClayCard yang bisa ditekan (onTap)
            ClayCard(
              color: AppColors.pinkHighlight,
              shadowColor: AppColors.cardShadow,
              onTap: () => setState(() => _lastTapped = 'ClayCard tappable'),
              child: Row(
                children: [
                  ClayContainer(
                    color: AppColors.pink,
                    shadowColor: AppColors.pinkShadow,
                    borderRadius: 14,
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('🥰', style: TextStyle(fontSize: 28)),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tap untuk buka detail',
                            style: AppTextStyles.headlineSmall),
                        Text('ClayCard dengan onTap callback',
                            style: AppTextStyles.bodySmall),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded,
                      color: AppColors.textHint),
                ],
              ),
            ),

            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 24),

            // ================================================
            // SECTION 3: ClayChip
            // ================================================
            Text('ClayChip – Label & Tag', style: AppTextStyles.headlineLarge),
            const SizedBox(height: 16),

            Wrap(
              // Wrap = seperti Row tapi otomatis pindah baris jika penuh
              spacing: 10,
              // spacing = jarak horizontal antar chip
              runSpacing: 10,
              // runSpacing = jarak vertikal antar baris
              children: [
                ClayChip(
                  label: 'Senang',
                  color: AppColors.mint,
                  shadowColor: AppColors.mintShadow,
                  leading: const Text('😊',
                      style: TextStyle(fontSize: 16)),
                ),
                ClayChip(
                  label: 'Minggu Ini',
                  color: AppColors.lavender,
                  shadowColor: AppColors.lavenderShadow,
                  leading: const Icon(Icons.date_range_rounded,
                      size: 16, color: AppColors.textOnClay),
                ),
                ClayChip(
                  label: 'Skor: 4.2',
                  color: AppColors.lemon,
                  shadowColor: AppColors.lemonShadow,
                  leading: const Icon(Icons.star_rounded,
                      size: 16, color: AppColors.textOnClay),
                ),
                ClayChip(
                  label: '7 Entri',
                  color: AppColors.skyBlue,
                  shadowColor: AppColors.skyBlueShadow,
                ),
                ClayChip(
                  label: 'Hapus Filter',
                  color: AppColors.pink,
                  shadowColor: AppColors.pinkShadow,
                  leading: const Icon(Icons.close_rounded,
                      size: 14, color: AppColors.textOnClay),
                ),
              ],
            ),

            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 24),

            // ================================================
            // SECTION 4: ClayContainer — elemen bebas
            // ================================================
            Text('ClayContainer – Elemen Bebas', style: AppTextStyles.headlineLarge),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Lingkaran clay besar (mood indicator)
                ClayContainer(
                  color: AppColors.pink,
                  shadowColor: AppColors.pinkShadow,
                  borderRadius: 50,
                  shadowDepth: 8,
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('😊', style: TextStyle(fontSize: 40)),
                  ),
                ),

                // Kotak clay medium
                ClayContainer(
                  color: AppColors.mint,
                  shadowColor: AppColors.mintShadow,
                  borderRadius: 20,
                  shadowDepth: 5,
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('🥰', style: TextStyle(fontSize: 32)),
                  ),
                ),

                // Kotak clay kecil
                ClayContainer(
                  color: AppColors.lemon,
                  shadowColor: AppColors.lemonShadow,
                  borderRadius: 14,
                  shadowDepth: 4,
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('😐', style: TextStyle(fontSize: 24)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}