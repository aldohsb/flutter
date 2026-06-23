import 'package:flutter/material.dart';

import '../models/user_profile.dart';
import '../theme/app_colors.dart';
import 'profile_avatar.dart';

/// Kartu yang merepresentasikan satu profil pengguna pada halaman pemilihan
/// profil, lengkap dengan opsi untuk membuka menu kelola (hapus/ubah nama).
class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.profile,
    required this.onTap,
    this.onLongPress,
  });

  final UserProfile profile;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        onLongPress: onLongPress,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ProfileAvatar(
                name: profile.name,
                color: Color(profile.avatarColorValue),
                size: 60,
              ),
              const SizedBox(height: 12),
              Text(
                profile.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
