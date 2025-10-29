import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/notification_provider.dart';
import '../providers/user_provider.dart';
import '../models/notification_setting_model.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';
import '../widgets/custom_button.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final userProvider = context.read<UserProvider>();
    if (userProvider.user != null) {
      await context
          .read<NotificationProvider>()
          .loadSettings(userProvider.user!.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Notifikasi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active),
            onPressed: _testNotification,
            tooltip: 'Test Notifikasi',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddNotificationDialog,
        child: const Icon(Icons.add),
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, notificationProvider, child) {
          if (notificationProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final settings = notificationProvider.settings;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Permission Status Card
                if (!notificationProvider.notificationsEnabled)
                  Card(
                    color: AppConstants.primaryRed.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(AppConstants.paddingMedium),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.warning,
                            color: AppConstants.primaryRed,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Notifikasi Dinonaktifkan',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                const Text(
                                  'Aktifkan notifikasi di pengaturan sistem untuk menerima pengingat motivasi.',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 16),

                // Info Card
                Card(
                  color: AppConstants.accentYellow.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.paddingMedium),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: AppConstants.accentYellow,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Atur waktu notifikasi motivasi untuk membantu Anda tetap konsisten dengan diet keto.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Settings List
                Text(
                  'Jadwal Notifikasi (${settings.length})',
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                const SizedBox(height: 16),

                if (settings.isEmpty)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppConstants.paddingLarge),
                      child: Center(
                        child: Column(
                          children: [
                            const Icon(
                              Icons.notifications_off,
                              size: 64,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Belum ada jadwal notifikasi',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Tap tombol + untuk menambah jadwal',
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  ...settings.map((setting) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: setting.isEnabled
                                ? AppConstants.primaryRed.withOpacity(0.1)
                                : Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(
                              AppConstants.radiusSmall,
                            ),
                          ),
                          child: Icon(
                            Icons.notifications,
                            color: setting.isEnabled
                                ? AppConstants.primaryRed
                                : Colors.grey,
                          ),
                        ),
                        title: Text(
                          setting.time,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text(
                          setting.isEnabled ? 'Aktif' : 'Nonaktif',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Switch(
                              value: setting.isEnabled,
                              onChanged: (_) async {
                                await notificationProvider
                                    .toggleSetting(setting.id!);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              color: AppConstants.primaryRed,
                              onPressed: () => _deleteNotification(setting),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _showAddNotificationDialog() async {
    TimeOfDay selectedTime = TimeOfDay.now();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Jadwal Notifikasi'),
        content: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Waktu'),
                subtitle: Text(selectedTime.format(context)),
                trailing: const Icon(Icons.access_time),
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                  );
                  if (time != null) {
                    setState(() => selectedTime = time);
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          CustomButton(
            text: 'Simpan',
            onPressed: () async {
              final userProvider = context.read<UserProvider>();
              final notificationProvider = context.read<NotificationProvider>();

              if (userProvider.user != null) {
                final timeString =
                    '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';

                final setting = NotificationSettingModel(
                  userId: userProvider.user!.id!,
                  time: timeString,
                  isEnabled: true,
                );

                final success = await notificationProvider.addSetting(setting);

                if (success && context.mounted) {
                  Navigator.pop(context);
                  Helpers.showSnackBar(
                    context,
                    'Jadwal notifikasi berhasil ditambahkan!',
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _deleteNotification(NotificationSettingModel setting) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Jadwal?'),
        content: Text('Yakin ingin menghapus notifikasi jam ${setting.time}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: AppConstants.primaryRed,
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      final success = await context
          .read<NotificationProvider>()
          .deleteSetting(setting.id!);

      if (success && mounted) {
        Helpers.showSnackBar(context, 'Jadwal berhasil dihapus');
      }
    }
  }

  Future<void> _testNotification() async {
    await context.read<NotificationProvider>().testNotification();
    if (mounted) {
      Helpers.showSnackBar(
        context,
        'Notifikasi test dikirim! Cek notifikasi Anda.',
      );
    }
  }
}