// Home screen - halaman utama aplikasi

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/water_provider.dart';
import '../widgets/water_tracker_widget.dart';
import '../widgets/reminder_card_widget.dart';
import '../utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar dengan custom design
      appBar: _buildAppBar(context),
      
      // Body dengan scrollable content
      body: RefreshIndicator(
        // Pull to refresh functionality
        onRefresh: () async {
          await context.read<WaterProvider>().refresh();
        },
        child: SingleChildScrollView(
          // physics untuk enable scroll bahkan saat content tidak overflow
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === WATER TRACKER SECTION ===
              const WaterTrackerWidget(),
              
              const SizedBox(height: AppConstants.paddingLarge),
              
              // === TODAY'S INTAKE SECTION ===
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingNormal,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today\'s Intake',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: AppConstants.paddingNormal),
                    
                    // List of today's intakes
                    _buildTodayIntakesList(context),
                  ],
                ),
              ),
              
              const SizedBox(height: AppConstants.paddingLarge),
              
              // === QUICK REMINDERS SECTION ===
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingNormal,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Reminders',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: AppConstants.paddingNormal),
                    
                    _buildQuickReminders(context),
                  ],
                ),
              ),
              
              const SizedBox(height: AppConstants.paddingLarge),
            ],
          ),
        ),
      ),
    );
  }

  // Build custom AppBar
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          // App icon/logo
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppConstants.primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.water_drop,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: AppConstants.paddingSmall),
          const Text('Water Reminder'),
        ],
      ),
      actions: [
        // Settings button
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () {
            _showSettingsBottomSheet(context);
          },
        ),
      ],
    );
  }

  // Build today's intakes list
  Widget _buildTodayIntakesList(BuildContext context) {
    return Consumer<WaterProvider>(
      builder: (context, provider, child) {
        // Jika loading
        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        
        // Jika tidak ada intake hari ini
        if (provider.todayIntakes.isEmpty) {
          return _buildEmptyState();
        }
        
        // List of intakes
        return ListView.builder(
          // shrinkWrap membuat ListView mengikuti ukuran content
          shrinkWrap: true,
          // Disable scroll karena sudah ada di parent
          physics: const NeverScrollableScrollPhysics(),
          itemCount: provider.todayIntakes.length,
          itemBuilder: (context, index) {
            final intake = provider.todayIntakes[index];
            // DateFormat dari package intl
            final timeFormat = DateFormat('HH:mm');
            
            return Card(
              child: ListTile(
                // Icon
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppConstants.primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.water_drop,
                    color: AppConstants.primaryColor,
                  ),
                ),
                
                // Title: amount
                title: Text(
                  '${intake.amountMl}ml',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                
                // Subtitle: time and note
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(timeFormat.format(intake.timestamp)),
                    if (intake.note != null && intake.note!.isNotEmpty)
                      Text(
                        intake.note!,
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                  ],
                ),
                
                // Trailing: delete button
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  color: Colors.red,
                  onPressed: () async {
                    // Confirmation dialog
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Intake'),
                        content: const Text(
                          'Are you sure you want to delete this intake?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );
                    
                    // Jika confirmed
                    if (confirm == true && context.mounted) {
                      await provider.deleteWaterIntake(intake.id);
                      
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Intake deleted'),
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Build empty state
  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      child: Column(
        children: [
          // Emoji
          const Text(
            '💧',
            style: TextStyle(fontSize: 64),
          ),
          const SizedBox(height: AppConstants.paddingNormal),
          
          // Text
          const Text(
            'No water intake today',
            style: TextStyle(
              fontSize: AppConstants.fontSizeLarge,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          const Text(
            'Start tracking your hydration now!',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  // Build quick reminders
  Widget _buildQuickReminders(BuildContext context) {
    return Consumer<WaterProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            ReminderCardWidget(
              icon: Icons.alarm,
              title: 'Wake up Early Morning',
              subtitle: 'Start your day with a glass of water',
              color: Colors.orange,
              onTap: () {},
            ),
            ReminderCardWidget(
              icon: Icons.local_drink,
              title: 'Reminder Taking water Bottle',
              subtitle: 'Don\'t forget your water bottle',
              color: Colors.blue,
              onTap: () {},
            ),
            ReminderCardWidget(
              icon: Icons.bedtime,
              title: 'Setting a alarm for drinking water',
              subtitle: 'Set regular reminders every ${AppConstants.defaultReminderInterval ~/ 60} hours',
              color: Colors.purple,
              onTap: () {
                _showReminderSettingsDialog(context, provider);
              },
            ),
          ],
        );
      },
    );
  }

  // Show settings bottom sheet
  void _showSettingsBottomSheet(BuildContext context) {
    final provider = context.read<WaterProvider>();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.borderRadiusLarge),
        ),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Settings',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppConstants.paddingLarge),
              
              // Notification toggle
              SwitchListTile(
                title: const Text('Enable Notifications'),
                subtitle: const Text('Receive water reminders'),
                value: provider.notificationsEnabled,
                onChanged: (value) {
                  provider.updateNotificationEnabled(value);
                },
              ),
              
              // Divider
              const Divider(),
              
              // Daily goal
              ListTile(
                title: const Text('Daily Goal'),
                subtitle: Text('${provider.dailyGoalMl}ml'),
                trailing: const Icon(Icons.edit),
                onTap: () {
                  Navigator.pop(context);
                  _showDailyGoalDialog(context, provider);
                },
              ),
              
              // Glass size
              ListTile(
                title: const Text('Default Glass Size'),
                subtitle: Text('${provider.glassSize}ml'),
                trailing: const Icon(Icons.edit),
                onTap: () {
                  Navigator.pop(context);
                  _showGlassSizeDialog(context, provider);
                },
              ),
              
              const SizedBox(height: AppConstants.paddingNormal),
            ],
          ),
        ),
      ),
    );
  }

  // Show daily goal dialog
  void _showDailyGoalDialog(BuildContext context, WaterProvider provider) {
    final controller = TextEditingController(
      text: provider.dailyGoalMl.toString(),
    );
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Set Daily Goal'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Daily Goal (ml)',
            suffixText: 'ml',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final goal = int.tryParse(controller.text);
              if (goal != null && goal > 0) {
                provider.updateDailyGoal(goal);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
    
    controller.dispose();
  }

  // Show glass size dialog
  void _showGlassSizeDialog(BuildContext context, WaterProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Set Default Glass Size'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: AppConstants.glassSizes.map((size) {
            return RadioListTile<int>(
              title: Text('${size}ml'),
              value: size,
              groupValue: provider.glassSize,
              onChanged: (value) {
                if (value != null) {
                  provider.updateGlassSize(value);
                  Navigator.pop(context);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  // Show reminder settings dialog
  void _showReminderSettingsDialog(
    BuildContext context,
    WaterProvider provider,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reminder Settings'),
        content: const Text(
          'Reminders are set to notify you every 2 hours between 7 AM and 10 PM.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}