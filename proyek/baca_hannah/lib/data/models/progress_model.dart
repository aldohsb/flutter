// lib/data/models/progress_model.dart

class ChapterProgress {
  final int chapterId;       // 1-based
  final int lastPageReached; // halaman terakhir dibaca (1-based)
  final int totalPages;
  final bool isCompleted;
  final DateTime? lastReadAt;

  const ChapterProgress({
    required this.chapterId,
    required this.lastPageReached,
    required this.totalPages,
    required this.isCompleted,
    this.lastReadAt,
  });

  double get progressPercent {
    if (totalPages == 0) return 0.0;
    return (lastPageReached / totalPages).clamp(0.0, 1.0);
  }

  int get stars {
    if (isCompleted) return 3;
    if (progressPercent >= 0.5) return 2;
    if (progressPercent > 0) return 1;
    return 0;
  }

  ChapterProgress copyWith({
    int? chapterId,
    int? lastPageReached,
    int? totalPages,
    bool? isCompleted,
    DateTime? lastReadAt,
  }) {
    return ChapterProgress(
      chapterId: chapterId ?? this.chapterId,
      lastPageReached: lastPageReached ?? this.lastPageReached,
      totalPages: totalPages ?? this.totalPages,
      isCompleted: isCompleted ?? this.isCompleted,
      lastReadAt: lastReadAt ?? this.lastReadAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chapterId': chapterId,
      'lastPageReached': lastPageReached,
      'totalPages': totalPages,
      'isCompleted': isCompleted,
      'lastReadAt': lastReadAt?.toIso8601String(),
    };
  }

  factory ChapterProgress.fromJson(Map<String, dynamic> json) {
    return ChapterProgress(
      chapterId: json['chapterId'] as int,
      lastPageReached: json['lastPageReached'] as int,
      totalPages: json['totalPages'] as int,
      isCompleted: json['isCompleted'] as bool,
      lastReadAt: json['lastReadAt'] != null
          ? DateTime.parse(json['lastReadAt'] as String)
          : null,
    );
  }

  factory ChapterProgress.initial(int chapterId, int totalPages) {
    return ChapterProgress(
      chapterId: chapterId,
      lastPageReached: 0,
      totalPages: totalPages,
      isCompleted: false,
    );
  }
}