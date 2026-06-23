import 'package:hive/hive.dart';

part 'user_profile.g.dart';

/// Merepresentasikan satu profil pengguna pada perangkat yang sama.
///
/// Setiap profil memiliki riwayat hasil tes tersendiri sehingga aplikasi
/// dapat digunakan bergantian oleh beberapa orang (mis. dalam satu keluarga
/// atau satu kelas) tanpa hasil tes saling tertukar.
@HiveType(typeId: 0)
class UserProfile extends HiveObject {
  UserProfile({
    required this.id,
    required this.name,
    required this.avatarColorValue,
    required this.createdAt,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  /// Nilai integer ARGB warna avatar, dipilih saat profil dibuat.
  @HiveField(2)
  int avatarColorValue;

  @HiveField(3)
  final DateTime createdAt;
}
