import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class ProfileAvatarWidget extends StatelessWidget {
  final double size;
  final String initials;
  final VoidCallback? onCameraTap;

  const ProfileAvatarWidget({
    super.key,
    this.size = 110,
    required this.initials,
    this.onCameraTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size + 16,
      height: size + 16,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildGradientRing(),
          _buildAvatar(),
          _buildCameraButton(),
        ],
      ),
    );
  }

  Widget _buildGradientRing() {
    return Container(
      width: size + 8,
      height: size + 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.accentPurple,
            AppColors.accentBlue,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryGlow,
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.backgroundSurface,
        border: Border.all(color: AppColors.backgroundCard, width: 3),
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/profile.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppColors.backgroundSurface,
              child: Center(
                child: Text(
                  initials,
                  style: TextStyle(
                    fontSize: size * 0.3,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCameraButton() {
    return Positioned(
      bottom: 4,
      right: 4,
      child: GestureDetector(
        onTap: onCameraTap,
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
            border: Border.all(color: AppColors.backgroundCard, width: 2),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryGlow,
                blurRadius: 8,
              ),
            ],
          ),
          child: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
        ),
      ),
    );
  }
}