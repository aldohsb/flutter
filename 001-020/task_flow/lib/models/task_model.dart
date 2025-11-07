// File ini mendefinisikan struktur data Task
// Model = blueprint/cetakan untuk data yang akan kita simpan

import 'package:hive/hive.dart';

// Anotasi untuk Hive, memberitahu Hive bahwa ini adalah model yang akan disimpan
// typeId = ID unik untuk tipe data ini di Hive (harus unik di aplikasi)
part 'task_model.g.dart'; // File yang akan di-generate otomatis

@HiveType(typeId: 0) // typeId harus unik untuk setiap model
class Task extends HiveObject {
  // HiveObject = class khusus Hive yang punya method save() dan delete()
  
  // @HiveField = anotasi untuk field yang akan disimpan
  // Angka dalam kurung = ID field, harus unik dalam model ini
  
  @HiveField(0)
  String id; // ID unik untuk setiap task (menggunakan timestamp)
  
  @HiveField(1)
  String title; // Judul task (contoh: "Beli susu")
  
  @HiveField(2)
  String description; // Deskripsi detail task (opsional)
  
  @HiveField(3)
  String category; // Kategori task (Work, Personal, dll)
  
  @HiveField(4)
  String priority; // Prioritas (Low, Medium, High)
  
  @HiveField(5)
  DateTime deadline; // Batas waktu task harus selesai
  
  @HiveField(6)
  bool isCompleted; // Status apakah task sudah selesai atau belum
  
  @HiveField(7)
  DateTime createdAt; // Waktu task dibuat
  
  @HiveField(8)
  int order; // Urutan task untuk drag & drop

  // Constructor = fungsi yang dipanggil saat membuat object Task baru
  Task({
    required this.id,           // required = harus diisi
    required this.title,
    this.description = '',      // default value = string kosong
    required this.category,
    required this.priority,
    required this.deadline,
    this.isCompleted = false,   // default value = false (belum selesai)
    required this.createdAt,
    this.order = 0,             // default value = 0
  });

  // Method untuk mengubah object Task menjadi Map (key-value pairs)
  // Berguna untuk debugging atau export data
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'priority': priority,
      'deadline': deadline.toIso8601String(), // Format tanggal ke string
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
      'order': order,
    };
  }

  // Factory constructor untuk membuat Task dari Map
  // Factory = konstruktor khusus yang bisa return instance yang sudah ada
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'] ?? '', // ?? = jika null, pakai nilai default
      category: map['category'],
      priority: map['priority'],
      deadline: DateTime.parse(map['deadline']), // Parse string ke DateTime
      isCompleted: map['isCompleted'],
      createdAt: DateTime.parse(map['createdAt']),
      order: map['order'] ?? 0,
    );
  }

  // Method untuk membuat copy Task dengan beberapa field yang diubah
  // Berguna karena di Flutter kita sering perlu membuat object baru daripada memodifikasi yang lama
  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? priority,
    DateTime? deadline,
    bool? isCompleted,
    DateTime? createdAt,
    int? order,
  }) {
    return Task(
      id: id ?? this.id,                     // ?? = jika null, pakai nilai original
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      deadline: deadline ?? this.deadline,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      order: order ?? this.order,
    );
  }
}