// Widget untuk menampilkan reminder cards di home screen

import 'package:flutter/material.dart';
import '../utils/constants.dart';

class ReminderCardWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Color? color;

  const ReminderCardWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    // Default color jika tidak di-set
    final cardColor = color ?? AppConstants.primaryColor;
    
    return Card(
      // Elevation untuk shadow effect
      elevation: 2,
      // Margin untuk spacing antar card
      margin: const EdgeInsets.only(bottom: AppConstants.paddingNormal),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusNormal),
        child: Container(
          padding: const EdgeInsets.all(AppConstants.paddingNormal),
          decoration: BoxDecoration(
            // Gradient background untuk modern look
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                cardColor.withValues(alpha: 0.1),
                cardColor.withValues(alpha: 0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusNormal),
          ),
          child: Row(
            children: [
              // === ICON SECTION ===
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: cardColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: cardColor,
                  size: 28,
                ),
              ),
              
              const SizedBox(width: AppConstants.paddingNormal),
              
              // === TEXT SECTION ===
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: cardColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
              // === ARROW ICON ===
              if (onTap != null)
                Icon(
                  Icons.chevron_right,
                  color: cardColor,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget untuk reminder card dengan ilustrasi gambar
class IllustrationReminderCard extends StatelessWidget {
  final String title;
  final String emoji;
  final VoidCallback? onTap;

  const IllustrationReminderCard({
    super.key,
    required this.title,
    required this.emoji,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusNormal),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingNormal),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Emoji besar
              Text(
                emoji,
                style: const TextStyle(fontSize: 48),
              ),
              const SizedBox(height: AppConstants.paddingSmall),
              
              // Title
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}