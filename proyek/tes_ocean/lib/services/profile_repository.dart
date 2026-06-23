import 'package:hive/hive.dart';

import '../models/user_profile.dart';
import '../utils/app_constants.dart';

/// Lapisan akses data untuk entitas [UserProfile].
///
/// Memisahkan logika baca/tulis Hive dari provider agar provider hanya
/// berurusan dengan state, bukan detail penyimpanan.
class ProfileRepository {
  Box<UserProfile> get _box => Hive.box<UserProfile>(
        AppConstants.userProfileBox,
      );

  List<UserProfile> getAll() {
    return _box.values.toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }

  UserProfile? getById(String id) {
    try {
      return _box.values.firstWhere((profile) => profile.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<void> add(UserProfile profile) async {
    await _box.put(profile.id, profile);
  }

  Future<void> update(UserProfile profile) async {
    await profile.save();
  }

  Future<void> delete(String id) async {
    await _box.delete(id);
  }

  Future<void> renameProfile(String id, String newName) async {
    final profile = getById(id);
    if (profile == null) return;
    profile.name = newName;
    await profile.save();
  }
}
