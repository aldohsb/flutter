// lib/models/task.dart
// Model data yang merepresentasikan satu item tugas di aplikasi Listivo

class Task {
  // ID unik tiap tugas, dibuat dari timestamp saat tugas dibuat
  final String id;

  // Judul tugas yang diketik pengguna
  final String title;

  // Status apakah tugas ini sudah selesai dikerjakan
  final bool isDone;

  // Waktu tugas dibuat, disimpan untuk kebutuhan pengurutan di masa depan
  final DateTime createdAt;

  // Constructor utama; isDone default false karena tugas baru pasti belum selesai
  const Task({
    required this.id,
    required this.title,
    this.isDone = false,
    required this.createdAt,
  });

  // copyWith memungkinkan kita membuat salinan Task dengan sebagian field diubah
  // tanpa melanggar prinsip immutability pada objek Task ini
  Task copyWith({bool? isDone}) {
    return Task(
      id: id, // id tidak pernah berubah sepanjang hidup objek
      title: title, // judul juga tetap sama, tidak diedit di app ini
      isDone: isDone ?? this.isDone, // hanya isDone yang boleh diganti
      createdAt: createdAt, // waktu pembuatan tidak pernah berubah
    );
  }
}