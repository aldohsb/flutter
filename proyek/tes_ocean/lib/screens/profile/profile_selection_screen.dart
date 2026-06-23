import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user_profile.dart';
import '../../providers/profile_provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/profile_card.dart';
import '../home_screen.dart';
import 'create_profile_sheet.dart';

/// Halaman pertama yang dilihat pengguna: memilih profil yang sudah ada
/// atau membuat profil baru, mirip pola pemilihan profil pada Netflix.
class ProfileSelectionScreen extends ConsumerWidget {
  const ProfileSelectionScreen({super.key});

  Future<void> _openCreateProfileSheet(BuildContext context, WidgetRef ref) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const CreateProfileSheet(),
    );
  }

  void _selectProfile(BuildContext context, WidgetRef ref, UserProfile profile) {
    ref.read(activeProfileIdProvider.notifier).set(profile.id);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  void _showManageSheet(BuildContext context, WidgetRef ref, UserProfile profile) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return SafeArea(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.delete_outline, color: AppColors.error),
                  title: const Text('Hapus Profil'),
                  subtitle: const Text('Seluruh riwayat tes profil ini juga akan terhapus'),
                  onTap: () async {
                    Navigator.of(sheetContext).pop();
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                        title: const Text('Hapus profil?'),
                        content: Text(
                          'Profil "${profile.name}" beserta seluruh riwayat hasil '
                          'tesnya akan dihapus permanen.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(dialogContext).pop(false),
                            child: const Text('Batal'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(dialogContext).pop(true),
                            child: const Text(
                              'Hapus',
                              style: TextStyle(color: AppColors.error),
                            ),
                          ),
                        ],
                      ),
                    );
                    if (confirmed == true) {
                      await ref
                          .read(profileListProvider.notifier)
                          .deleteProfile(profile.id);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profiles = ref.watch(profileListProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.psychology_alt_rounded,
                    color: Colors.white, size: 30),
              ),
              const SizedBox(height: 20),
              const Text(
                'Tes Kepribadian OCEAN',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Pilih profil untuk melanjutkan, atau buat profil baru.',
                style: TextStyle(fontSize: 15, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 28),
              Expanded(
                child: profiles.isEmpty
                    ? EmptyState(
                        icon: Icons.person_add_alt_1_rounded,
                        title: 'Belum ada profil',
                        message: 'Buat profil pertama Anda untuk mulai '
                            'mengerjakan tes kepribadian OCEAN.',
                        action: PrimaryButton(
                          label: 'Buat Profil',
                          icon: Icons.add_rounded,
                          expand: false,
                          onPressed: () => _openCreateProfileSheet(context, ref),
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.only(bottom: 24),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 14,
                          crossAxisSpacing: 14,
                          childAspectRatio: 0.82,
                        ),
                        itemCount: profiles.length,
                        itemBuilder: (context, index) {
                          final profile = profiles[index];
                          return ProfileCard(
                            profile: profile,
                            onTap: () => _selectProfile(context, ref, profile),
                            onLongPress: () =>
                                _showManageSheet(context, ref, profile),
                          );
                        },
                      ),
              ),
              if (profiles.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: PrimaryButton(
                    label: 'Tambah Profil Baru',
                    icon: Icons.add_rounded,
                    onPressed: () => _openCreateProfileSheet(context, ref),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
