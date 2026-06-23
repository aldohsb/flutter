import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/user_profile.dart';
import '../services/profile_repository.dart';
import '../theme/app_colors.dart';

const _uuid = Uuid();

/// Menyediakan instance [ProfileRepository] tunggal untuk seluruh aplikasi.
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository();
});

/// Menyediakan dan mengelola daftar seluruh profil pengguna yang tersimpan
/// di perangkat. Menggunakan [Notifier] (bukan StateNotifier) sesuai API
/// Riverpod terkini.
class ProfileListNotifier extends Notifier<List<UserProfile>> {
  @override
  List<UserProfile> build() {
    final repo = ref.watch(profileRepositoryProvider);
    return repo.getAll();
  }

  Future<UserProfile> createProfile(String name) async {
    final repo = ref.read(profileRepositoryProvider);
    final colorValue = AppColors
        .profileAvatarPalette[state.length % AppColors.profileAvatarPalette.length]
        .toARGB32();

    final profile = UserProfile(
      id: _uuid.v4(),
      name: name.trim(),
      avatarColorValue: colorValue,
      createdAt: DateTime.now(),
    );

    await repo.add(profile);
    state = repo.getAll();
    return profile;
  }

  Future<void> renameProfile(String id, String newName) async {
    final repo = ref.read(profileRepositoryProvider);
    await repo.renameProfile(id, newName.trim());
    state = repo.getAll();
  }

  Future<void> deleteProfile(String id) async {
    final repo = ref.read(profileRepositoryProvider);
    await repo.delete(id);
    state = repo.getAll();
  }
}

final profileListProvider =
    NotifierProvider<ProfileListNotifier, List<UserProfile>>(
  ProfileListNotifier.new,
);

/// Menyimpan id profil yang sedang aktif digunakan pada sesi berjalan.
class ActiveProfileIdNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void set(String id) => state = id;

  void clear() => state = null;
}

final activeProfileIdProvider =
    NotifierProvider<ActiveProfileIdNotifier, String?>(
  ActiveProfileIdNotifier.new,
);

/// Mengembalikan objek [UserProfile] yang sedang aktif, atau null jika
/// belum ada profil yang dipilih.
final activeProfileProvider = Provider<UserProfile?>((ref) {
  final id = ref.watch(activeProfileIdProvider);
  if (id == null) return null;

  final profiles = ref.watch(profileListProvider);
  for (final profile in profiles) {
    if (profile.id == id) return profile;
  }
  return null;
});
