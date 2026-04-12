import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_colors.dart';
import '../widgets/stat_column_widget.dart';
import '../widgets/profile_avatar_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String _nama      = 'Aldo Setiawan';
  static const String _username  = '@letterhanna';
  static const String _bio       = 'Font designer & type enthusiast.\nCrafting letterforms from Yogyakarta 🇮🇩\nShop → letterhanna.com';
  static const String _initials  = 'AS';

  static final List<Map<String, dynamic>> _stats = [
    {'label': 'Posts',     'value': '128',   'color': AppColors.primary},
    {'label': 'Followers', 'value': '4.2K',  'color': AppColors.accentBlue},
    {'label': 'Following', 'value': '312',   'color': AppColors.accentPurple},
  ];

  static final List<Map<String, String>> _highlights = [
    {'icon': '🎨', 'label': 'Fonts'},
    {'icon': '✍️', 'label': 'Process'},
    {'icon': '📦', 'label': 'Bundles'},
    {'icon': '💬', 'label': 'Q&A'},
  ];

  static final List<Map<String, dynamic>> _posts = List.generate(
    9,
    (i) => {
      'index': i,
      'color': i % 3 == 0
          ? AppColors.backgroundSurface
          : i % 3 == 1
              ? AppColors.backgroundChip
              : AppColors.backgroundCard,
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(),
              _buildProfileSection(),
              _buildStatsRow(),
              _buildActionButtons(),
              _buildHighlights(),
              _buildDivider(),
              _buildPostsGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.lock_outline, size: 14, color: AppColors.textPrimary),
              const SizedBox(width: 6),
              Text(
                _username,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.textPrimary),
            ],
          ),
          Row(
            children: [
              _buildTopBarIcon(Icons.add_box_outlined),
              const SizedBox(width: 16),
              _buildTopBarIcon(Icons.menu),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopBarIcon(IconData icon) {
    return Icon(icon, size: 26, color: AppColors.textPrimary);
  }

  Widget _buildProfileSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileAvatarWidget(initials: _initials, size: 90),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Text(
                  _nama,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Letterhanna Studio',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _bio,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _stats.map((stat) {
          return StatColumnWidget(
            value: stat['value'] as String,
            label: stat['label'] as String,
            accentColor: stat['color'] as Color,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Row(
        children: [
          Expanded(child: _buildPrimaryButton()),
          const SizedBox(width: 8),
          Expanded(child: _buildSecondaryButton()),
          const SizedBox(width: 8),
          _buildIconButton(),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton() {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.accentPurple],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          'Edit Profile',
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton() {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.backgroundSurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.divider),
      ),
      child: Center(
        child: Text(
          'Share Profile',
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.backgroundSurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.divider),
      ),
      child: const Icon(Icons.person_add_outlined, size: 18, color: AppColors.textPrimary),
    );
  }

  Widget _buildHighlights() {
    return SizedBox(
      height: 96,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        scrollDirection: Axis.horizontal,
        itemCount: _highlights.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return _buildHighlightItem(_highlights[index]);
        },
      ),
    );
  }

  Widget _buildHighlightItem(Map<String, String> item) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.6),
                    AppColors.accentPurple.withValues(alpha: 0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Container(
              width: 52,
              height: 52,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.backgroundSurface,
              ),
              child: Center(
                child: Text(item['icon']!, style: const TextStyle(fontSize: 22)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          item['label']!,
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(height: 1, color: AppColors.divider),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.grid_on,
                size: 20,
                color: AppColors.primary,
              ),
            ),
            Expanded(
              child: Container(height: 1, color: AppColors.divider),
            ),
          ],
        ),
        const SizedBox(height: 2),
      ],
    );
  }

  Widget _buildPostsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        return _buildPostTile(_posts[index], index);
      },
    );
  }

  Widget _buildPostTile(Map<String, dynamic> post, int index) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: post['color'] as Color,
          child: Center(
            child: Icon(
              Icons.image_outlined,
              color: AppColors.textMuted.withValues(alpha: 0.4),
              size: 32,
            ),
          ),
        ),
        if (index == 0)
          Positioned(
            top: 6,
            left: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'PINNED',
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
      ],
    );
  }
}