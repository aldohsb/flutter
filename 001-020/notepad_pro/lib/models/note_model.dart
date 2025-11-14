import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  String id;
  
  @HiveField(1)
  String title;
  
  @HiveField(2)
  String content;
  
  @HiveField(3)
  DateTime createdAt;
  
  @HiveField(4)
  DateTime updatedAt;
  
  @HiveField(5)
  String folderId;
  
  @HiveField(6)
  List<String> tags;
  
  @HiveField(7)
  bool isFavorite;
  
  @HiveField(8)
  String? color;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.folderId,
    this.tags = const [],
    this.isFavorite = false,
    this.color,
  });

  // Factory untuk create note baru
  factory NoteModel.create({
    required String id,
    required String title,
    required String folderId,
    String content = '',
  }) {
    final now = DateTime.now();
    return NoteModel(
      id: id,
      title: title,
      content: content,
      createdAt: now,
      updatedAt: now,
      folderId: folderId,
      tags: [],
      isFavorite: false,
    );
  }

  // Copy with untuk update
  NoteModel copyWith({
    String? title,
    String? content,
    DateTime? updatedAt,
    String? folderId,
    List<String>? tags,
    bool? isFavorite,
    String? color,
  }) {
    return NoteModel(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      folderId: folderId ?? this.folderId,
      tags: tags ?? this.tags,
      isFavorite: isFavorite ?? this.isFavorite,
      color: color ?? this.color,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'folderId': folderId,
      'tags': tags,
      'isFavorite': isFavorite,
      'color': color,
    };
  }

  // Create from JSON
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      folderId: json['folderId'] as String,
      tags: List<String>.from(json['tags'] as List),
      isFavorite: json['isFavorite'] as bool,
      color: json['color'] as String?,
    );
  }
  
  // Get preview text (100 karakter pertama)
  String get preview {
    final plainText = content.replaceAll(RegExp(r'[*_]'), '');
    return plainText.length > 100 
        ? '${plainText.substring(0, 100)}...' 
        : plainText;
  }
}