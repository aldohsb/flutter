import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../providers/app_providers.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Audio Settings
            _buildSectionTitle(context, 'Audio'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Consumer<AudioProvider>(
                  builder: (context, audioProvider, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sound Effects',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              audioProvider.isMuted ? 'Muted' : 'On',
                              style: const TextStyle(
                                color: AppColors.textMid,
                                fontSize: AppFontSizes.md,
                              ),
                            ),
                          ],
                        ),
                        Switch(
                          value: !audioProvider.isMuted,
                          onChanged: (_) {
                            audioProvider.toggleMute();
                          },
                          activeThumbColor: AppColors.primaryMain,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),

            // Display Settings
            _buildSectionTitle(context, 'Display'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  children: [
                    _buildSettingOption(
                      title: 'Show Explanations',
                      subtitle: 'Display answer explanations',
                      value: true,
                    ),
                    const Divider(height: AppSpacing.xl),
                    _buildSettingOption(
                      title: 'Show Category Badge',
                      subtitle: 'Display hiragana/katakana/kanji label',
                      value: true,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),

            // Quiz Settings
            _buildSectionTitle(context, 'Quiz'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  children: [
                    _buildSettingOption(
                      title: 'Auto-advance',
                      subtitle: 'Automatically go to next question',
                      value: false,
                    ),
                    const Divider(height: AppSpacing.xl),
                    _buildSettingOption(
                      title: 'Show Timer',
                      subtitle: 'Display time spent per question',
                      value: false,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),

            // About Section
            _buildSectionTitle(context, 'About'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAboutItem('App Name', 'UsamaQuiz'),
                    const SizedBox(height: AppSpacing.lg),
                    _buildAboutItem('Version', '1.0.0'),
                    const SizedBox(height: AppSpacing.lg),
                    _buildAboutItem('Build', '1'),
                    const SizedBox(height: AppSpacing.lg),
                    _buildAboutItem('Developer', 'RInaldo Hasibuan'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),

            // Danger Zone
            _buildSectionTitle(context, 'Danger Zone', isDanger: true),
            Card(
              color: AppColors.error.withOpacity(0.05),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () => _showResetDialog(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                      ),
                      child: const Text('Reset All Progress'),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const Text(
                      'This will reset all levels and progress for the current user. Cannot be undone.',
                      style: TextStyle(
                        fontSize: AppFontSizes.sm,
                        color: AppColors.textMid,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title,
      {bool isDanger = false}) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSpacing.xxl,
        bottom: AppSpacing.lg,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: isDanger ? AppColors.error : AppColors.textDark,
            ),
      ),
    );
  }

  Widget _buildSettingOption({
    required String title,
    required String subtitle,
    required bool value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                subtitle,
                style: const TextStyle(
                  color: AppColors.textMid,
                  fontSize: AppFontSizes.md,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: (_) {},
          activeThumbColor: AppColors.primaryMain,
        ),
      ],
    );
  }

  Widget _buildAboutItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textMid,
            fontSize: AppFontSizes.md,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: AppFontSizes.md,
          ),
        ),
      ],
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Progress'),
        content: const Text(
          'Are you sure you want to reset all progress? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement reset logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Progress reset successfully')),
              );
            },
            child: const Text(
              'Reset',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}