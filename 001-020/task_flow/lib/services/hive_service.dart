// File ini mengelola semua operasi database dengan Hive
// Service = layer yang mengurus komunikasi dengan database

import 'package:hive_flutter/hive_flutter.dart';
import '../models/task_model.dart';
import '../utils/constants.dart';

// Kelas untuk mengelola Hive database
class HiveService {
  // Static instance untuk Singleton pattern
  // Singleton = memastikan hanya ada 1 instance HiveService di seluruh aplikasi
  static final HiveService _instance = HiveService._internal();
  
  // Factory constructor yang selalu return instance yang sama
  factory HiveService() => _instance;
  
  // Private constructor (tidak bisa dipanggil dari luar class)
  HiveService._internal();

  // Box untuk menyimpan tasks
  // Box = seperti tabel di database tradisional
  Box<Task>? _taskBox;

  // Getter untuk mengakses task box
  // Getter = property yang calculated, seperti function tapi dipanggil seperti variable
  Box<Task> get taskBox {
    if (_taskBox == null) {
      // Jika box belum diinisialisasi, throw error
      throw Exception('Task box belum diinisialisasi. Panggil init() terlebih dahulu.');
    }
    return _taskBox!; // ! = assert bahwa variable tidak null
  }

  // Inisialisasi Hive database
  // Async = fungsi yang berjalan asynchronous (tidak blocking)
  // Future = promise/janji bahwa fungsi ini akan selesai di masa depan
  Future<void> init() async {
    // Inisialisasi Hive untuk Flutter
    // Harus dipanggil sebelum menggunakan Hive
    await Hive.initFlutter();

    // Register adapter untuk Task model
    // Adapter = translator yang mengubah object Dart menjadi format Hive
    // Cek dulu apakah sudah terdaftar untuk menghindari error
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskAdapter());
    }

    // Buka box untuk tasks
    // await = tunggu sampai operasi selesai sebelum lanjut ke baris berikutnya
    _taskBox = await Hive.openBox<Task>(AppConstants.tasksBoxName);
  }

  // Simpan task baru ke database
  Future<void> addTask(Task task) async {
    // put() = simpan dengan key (id) dan value (task)
    // Jika id sudah ada, akan di-overwrite
    await taskBox.put(task.id, task);
  }

  // Update task yang sudah ada
  Future<void> updateTask(Task task) async {
    // save() = method dari HiveObject untuk menyimpan perubahan
    // Lebih efisien daripada put() karena hanya update yang berubah
    await task.save();
  }

  // Hapus task dari database
  Future<void> deleteTask(String id) async {
    // delete() = hapus data dengan key tertentu
    await taskBox.delete(id);
  }

  // Ambil semua tasks dari database
  List<Task> getAllTasks() {
    // values = ambil semua value dari box (tanpa key)
    // toList() = konversi dari iterable ke List
    return taskBox.values.toList();
  }

  // Ambil task berdasarkan ID
  Task? getTaskById(String id) {
    // get() = ambil value berdasarkan key
    // Return null jika tidak ditemukan
    return taskBox.get(id);
  }

  // Hapus semua tasks (untuk fitur clear all)
  Future<void> deleteAllTasks() async {
    // clear() = hapus semua data di box
    await taskBox.clear();
  }

  // Ambil tasks berdasarkan kategori
  List<Task> getTasksByCategory(String category) {
    // where() = filter data berdasarkan kondisi
    // (task) => kondisi = arrow function untuk cek kondisi
    return taskBox.values
        .where((task) => task.category == category)
        .toList();
  }

  // Ambil tasks berdasarkan status completion
  List<Task> getTasksByCompletion(bool isCompleted) {
    return taskBox.values
        .where((task) => task.isCompleted == isCompleted)
        .toList();
  }

  // Ambil tasks yang overdue (deadline sudah lewat tapi belum selesai)
  List<Task> getOverdueTasks() {
    final now = DateTime.now();
    return taskBox.values
        .where((task) => 
            !task.isCompleted && 
            task.deadline.isBefore(now))
        .toList();
  }

  // Tutup database (biasanya dipanggil saat app ditutup)
  Future<void> close() async {
    await taskBox.close();
  }
}