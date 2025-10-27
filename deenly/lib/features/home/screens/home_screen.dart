import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';

/// Home Screen - Halaman utama aplikasi Deenly
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppConstants.radiusS),
              ),
              child: const Icon(
                Icons.book_outlined,
                color: AppColors.textLight,
              ),
            ),
            const SizedBox(width: AppConstants.paddingM),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppConstants.appName,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  AppConstants.appTagline,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppConstants.paddingL),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppConstants.radiusL),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Assalamu\'alaikum,',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textLight.withOpacity(0.9),
                        ),
                  ),
                  const SizedBox(height: AppConstants.paddingXS),
                  Text(
                    'Selamat datang kembali!',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: AppColors.textLight,
                        ),
                  ),
                  const SizedBox(height: AppConstants.paddingM),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.paddingM,
                      vertical: AppConstants.paddingS,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(AppConstants.radiusS),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.local_fire_department,
                          color: AppColors.textLight,
                          size: AppConstants.iconS,
                        ),
                        const SizedBox(width: AppConstants.paddingS),
                        Text(
                          '7 hari berturut-turut',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.textLight,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppConstants.paddingL),

            // Section Title
            Text(
              'Kursus Populer',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: AppConstants.paddingM),

            // Dummy Course Cards
            _buildCourseCard(
              context,
              'Dasar-Dasar Aqidah',
              'Pelajari fondasi keimanan Islam',
              '12 Video',
              0.6,
            ),
            const SizedBox(height: AppConstants.paddingM),
            _buildCourseCard(
              context,
              'Fiqih Ibadah Sehari-hari',
              'Panduan praktis ibadah harian',
              '15 Video',
              0.3,
            ),
            const SizedBox(height: AppConstants.paddingM),
            _buildCourseCard(
              context,
              'Sirah Nabawiyah',
              'Kisah hidup Rasulullah SAW',
              '20 Video',
              0.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCard(
    BuildContext context,
    String title,
    String subtitle,
    String duration,
    double progress,
  ) {
    return Card(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(AppConstants.radiusM),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingM),
          child: Row(
            children: [
              // Thumbnail
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppConstants.radiusM),
                ),
                child: const Icon(
                  Icons.play_circle_outline,
                  size: AppConstants.iconXL,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppConstants.paddingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppConstants.paddingXS),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppConstants.paddingS),
                    Row(
                      children: [
                        Icon(
                          Icons.video_library,
                          size: AppConstants.iconXS,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: AppConstants.paddingXS),
                        Text(
                          duration,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const Spacer(),
                        if (progress > 0) ...[
                          Text(
                            '${(progress * 100).toInt()}%',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ],
                    ),
                    if (progress > 0) ...[
                      const SizedBox(height: AppConstants.paddingS),
                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppConstants.radiusS),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: AppColors.divider,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                          minHeight: 4,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}