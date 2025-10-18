import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_constants.dart';
import '../../providers/app_providers.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Audio Settings
            _buildSectionTitle(context, 'Audio'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.lg),
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
                            SizedBox(height: AppSpacing.sm),
                            Text(
                              audioProvider.isMuted ? 'Muted' : 'On',
                              style: TextStyle(
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
                          activeColor: AppColors.primaryMain,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            SizedBox(height: AppSpacing.xxl),

            // Display Settings
            _buildSectionTitle(context, 'Display'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  children: [
                    _buildSettingOption(
                      title: 'Show Explanations',
                      subtitle: 'Display answer explanations',
                      value: true,
                    ),
                    Divider(height: AppSpacing.xl),
                    _buildSettingOption(
                      title: 'Show Category Badge',
                      subtitle: 'Display hiragana/katakana/kanji label',
                      value: true,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: AppSpacing.xxl),

            // Quiz Settings
            _buildSectionTitle(context, 'Quiz'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  children: [
                    _buildSettingOption(
                      title: 'Auto-advance',
                      subtitle: 'Automatically go to next question',
                      value: false,
                    ),
                    Divider(height: AppSpacing.xl),
                    _buildSettingOption(
                      title: 'Show Timer',
                      subtitle: 'Display time spent per question',
                      value: false,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: AppSpacing.xxl),

            // About Section
            _buildSectionTitle(context, 'About'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAboutItem('App Name', 'UsamaQuiz'),
                    SizedBox(height: AppSpacing.lg),
                    _buildAboutItem('Version', '1.0.0'),
                    SizedBox(height: AppSpacing.lg),
                    _buildAboutItem('Build', '1'),
                    SizedBox(height: AppSpacing.lg),
                    _buildAboutItem('Developer', 'RInaldo Hasibuan'),
                  ],
                ),
              ),
            ),

            SizedBox(height: AppSpacing.xxl),

            // Danger Zone
            _buildSectionTitle(context, 'Danger Zone', isDanger: true),
            Card(
              color: AppColors.error.withOpacity(0.05),
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () => _showResetDialog(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                      ),
                      child: Text('Reset All Progress'),
                    ),
                    SizedBox(height: AppSpacing.md),
                    Text(
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

            SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title,
      {bool isDanger = false}) {
    return Padding(
      padding: EdgeInsets.only(
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
              SizedBox(height: AppSpacing.sm),
              Text(
                subtitle,
                style: TextStyle(
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
          activeColor: AppColors.primaryMain,
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
          style: TextStyle(
            color: AppColors.textMid,
            fontSize: AppFontSizes.md,
          ),
        ),
        Text(
          value,
          style: TextStyle(
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
        title: Text('Reset Progress'),
        content: Text(
          'Are you sure you want to reset all progress? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement reset logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Progress reset successfully')),
              );
            },
            child: Text(
              'Reset',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}