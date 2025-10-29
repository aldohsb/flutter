import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';
import '../widgets/stat_card.dart';
import 'notification_settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          final user = userProvider.user;
          if (user == null) {
            return const Center(child: Text('No user data'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child: Column(
              children: [
                // Profile Header
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.paddingLarge),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: AppConstants.primaryRed,
                          child: Text(
                            user.name[0].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          user.name,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          user.gender.displayName,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Stats
                CompactStatCard(
                  label: 'Tinggi Badan',
                  value: '${user.height.toStringAsFixed(0)} cm',
                  icon: Icons.height,
                  color: AppConstants.primaryRed,
                ),

                const SizedBox(height: 12),

                CompactStatCard(
                  label: 'BMI',
                  value: Helpers.formatBMI(user.bmi),
                  icon: Icons.analytics,
                  color: Helpers.getBMIColor(user.bmi),
                ),

                const SizedBox(height: 12),

                CompactStatCard(
                  label: 'Target Berat',
                  value: Helpers.formatWeight(user.targetWeight),
                  icon: Icons.flag,
                  color: AppConstants.accentYellow,
                ),

                const SizedBox(height: 12),

                CompactStatCard(
                  label: 'Mulai Diet',
                  value: Helpers.formatDate(user.startDate),
                  icon: Icons.calendar_today,
                  color: AppConstants.ratingExcellent,
                ),

                const SizedBox(height: 24),

                // Settings
                Card(
                  child: Column(
                    children: [
                      Consumer<ThemeProvider>(
                        builder: (context, themeProvider, child) {
                          return SwitchListTile(
                            title: const Text('Mode Gelap'),
                            subtitle: const Text('Tema aplikasi'),
                            secondary: Icon(
                              themeProvider.isDarkMode
                                  ? Icons.dark_mode
                                  : Icons.light_mode,
                            ),
                            value: themeProvider.isDarkMode,
                            onChanged: (_) => themeProvider.toggleTheme(),
                          );
                        },
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.notifications),
                        title: const Text('Notifikasi'),
                        subtitle: const Text('Atur pengingat motivasi'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const NotificationSettingsScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // App Info
                Text(
                  '${AppConstants.appName} v${AppConstants.appVersion}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}