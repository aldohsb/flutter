import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import '../providers/timer_provider.dart';
import '../../core/utils/window_helper.dart';
import '../../core/constants/app_constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          TextButton(
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Reset Settings'),
                  content: const Text('Reset all settings to default values?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              );
              
              if (confirmed == true && context.mounted) {
                await context.read<SettingsProvider>().resetToDefaults();
                await WindowHelper.setOpacity(AppConstants.defaultOpacity);
                await WindowHelper.setAlwaysOnTop(true);
              }
            },
            child: const Text('Reset'),
          ),
        ],
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, provider, _) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildSection(
                context,
                'Window',
                [
                  _buildOpacitySlider(context, provider),
                  _buildAlwaysOnTopSwitch(context, provider),
                ],
              ),
              const SizedBox(height: 24),
              _buildSection(
                context,
                'Timer',
                [
                  _buildIdleThresholdSlider(context, provider),
                  _buildFontSizeSlider(context, provider),
                ],
              ),
              const SizedBox(height: 24),
              _buildSection(
                context,
                'Keyboard Shortcuts',
                [
                  _buildHotkeyField(
                    context,
                    'Pause/Resume',
                    provider.pauseHotkey,
                    (value) => provider.setPauseHotkey(value),
                  ),
                  const SizedBox(height: 12),
                  _buildHotkeyField(
                    context,
                    'Reset Timer',
                    provider.resetHotkey,
                    (value) => provider.setResetHotkey(value),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSection(
                context,
                'About',
                [
                  ListTile(
                    title: const Text('Version'),
                    subtitle: const Text(AppConstants.appVersion),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
  
  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: children,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildOpacitySlider(BuildContext context, SettingsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Window Opacity'),
            Text(
              '${(provider.opacity * 100).toInt()}%',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        Slider(
          value: provider.opacity,
          min: AppConstants.minOpacity,
          max: AppConstants.maxOpacity,
          divisions: 70,
          onChanged: (value) async {
            await provider.setOpacity(value);
            await WindowHelper.setOpacity(value);
          },
        ),
      ],
    );
  }
  
  Widget _buildAlwaysOnTopSwitch(BuildContext context, SettingsProvider provider) {
    return SwitchListTile(
      title: const Text('Always On Top'),
      subtitle: const Text('Keep timer window above other windows'),
      value: provider.alwaysOnTop,
      onChanged: (value) async {
        await provider.setAlwaysOnTop(value);
        await WindowHelper.setAlwaysOnTop(value);
      },
      contentPadding: EdgeInsets.zero,
    );
  }
  
  Widget _buildIdleThresholdSlider(BuildContext context, SettingsProvider provider) {
    final minutes = provider.idleThresholdSeconds ~/ 60;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Idle Threshold'),
            Text(
              '$minutes minutes',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Text(
          'Auto-pause after this period of inactivity',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Slider(
          value: minutes.toDouble(),
          min: 1,
          max: 30,
          divisions: 29,
          onChanged: (value) async {
            final seconds = value.toInt() * 60;
            await provider.setIdleThreshold(seconds);
            if (context.mounted) {
              context.read<TimerProvider>().updateIdleThreshold(seconds);
            }
          },
        ),
      ],
    );
  }
  
  Widget _buildFontSizeSlider(BuildContext context, SettingsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Timer Font Size'),
            Text(
              '${provider.fontSize.toInt()}px',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        Slider(
          value: provider.fontSize,
          min: AppConstants.timerFontSizeSmall,
          max: AppConstants.timerFontSizeLarge,
          divisions: 8,
          onChanged: (value) => provider.setFontSize(value),
        ),
      ],
    );
  }
  
  Widget _buildHotkeyField(
    BuildContext context,
    String label,
    String value,
    Function(String) onChanged,
  ) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        hintText: 'e.g., ctrl+alt+p',
        border: const OutlineInputBorder(),
      ),
      controller: TextEditingController(text: value),
      onSubmitted: (newValue) async {
        await onChanged(newValue);
        if (context.mounted) {
          await context.read<TimerProvider>().updateShortcuts();
        }
      },
    );
  }
}
