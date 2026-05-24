class Habit {                                    // model data satu habit — dipindah ke file sendiri
  final String title;                            // nama habit — tidak berubah setelah dibuat
  final bool isDone;                             // status selesai hari ini

  const Habit({
    required this.title,
    this.isDone = false,                         // default false — habit baru selalu belum selesai
  });

  Habit copyWith({bool? isDone}) {               // buat salinan dengan isDone baru — title tetap sama
    return Habit(
      title: title,
      isDone: isDone ?? this.isDone,             // pakai nilai lama kalau parameter tidak diisi
    );
  }
}