// File ini adalah "otak" aplikasi yang mengelola semua state dan logic tasks
// Provider = class yang menyimpan data dan memberitahu UI saat ada perubahan

import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/hive_service.dart';
import '../services/notification_service.dart';

// ChangeNotifier = class yang bisa memberitahu listener saat ada perubahan
// Seperti "broadcaster" yang mengumumkan perubahan ke semua pendengar
class TaskProvider extends ChangeNotifier {
  // Instance services
  final HiveService _hiveService = HiveService();
  final NotificationService _notificationService = NotificationService();

  // List semua tasks
  List<Task> _tasks = [];

  // Filter yang sedang aktif
  String _selectedCategory = 'All'; // Default: tampilkan semua
  String _selectedPriority = 'All'; // Default: tampilkan semua
  bool _showCompletedOnly = false;  // Default: tampilkan semua status

  // Getters untuk mengakses data dari luar class
  // Getter = cara membaca data secara read-only dari luar class
  List<Task> get tasks => _getFilteredTasks(); // Return tasks yang sudah difilter
  String get selectedCategory => _selectedCategory;
  String get selectedPriority => _selectedPriority;
  bool get showCompletedOnly => _showCompletedOnly;

  // Statistik tasks
  int get totalTasks => _tasks.length;
  int get completedTasks => _tasks.where((task) => task.isCompleted).length;
  int get pendingTasks => _tasks.where((task) => !task.isCompleted).length;
  int get overdueTasks => _tasks.where((task) => 
      !task.isCompleted && task.deadline.isBefore(DateTime.now())).length;

  // Load semua tasks dari database saat pertama kali
  Future<void> loadTasks() async {
    // Ambil semua tasks dari Hive
    _tasks = _hiveService.getAllTasks();
    
    // Sort berdasarkan order (untuk drag & drop)
    _tasks.sort((a, b) => a.order.compareTo(b.order));
    
    // Beritahu semua listener bahwa data sudah berubah
    // notifyListeners() = trigger rebuild UI yang mendengarkan provider ini
    notifyListeners();
  }

  // Tambah task baru
  Future<void> addTask(Task task) async {
    // Set order untuk task baru (taruh di paling akhir)
    task.order = _tasks.length;
    
    // Simpan ke database
    await _hiveService.addTask(task);
    
    // Tambahkan ke list lokal
    _tasks.add(task);
    
    // Schedule reminder notifikasi
    await _notificationService.scheduleTaskReminder(task);
    
    // Beritahu UI untuk update
    notifyListeners();
  }

  // Update task yang sudah ada
  Future<void> updateTask(Task task) async {
    // Cari index task di list
    final index = _tasks.indexWhere((t) => t.id == task.id);
    
    if (index != -1) {
      // Update di list lokal
      _tasks[index] = task;
      
      // Update di database
      await _hiveService.updateTask(task);
      
      // Update reminder notification
      // Cancel yang lama dulu
      await _notificationService.cancelTaskReminder(task.id);
      
      // Jika belum completed, schedule lagi
      if (!task.isCompleted) {
        await _notificationService.scheduleTaskReminder(task);
      }
      
      // Beritahu UI
      notifyListeners();
    }
  }

  // Hapus task
  Future<void> deleteTask(String id) async {
    // Hapus dari database
    await _hiveService.deleteTask(id);
    
    // Hapus dari list lokal
    _tasks.removeWhere((task) => task.id == id);
    
    // Cancel reminder
    await _notificationService.cancelTaskReminder(id);
    
    // Update order tasks yang tersisa
    for (int i = 0; i < _tasks.length; i++) {
      _tasks[i].order = i;
      await _hiveService.updateTask(_tasks[i]);
    }
    
    // Beritahu UI
    notifyListeners();
  }

  // Toggle status completed task
  Future<void> toggleTaskCompletion(String id) async {
    // Cari task
    final index = _tasks.indexWhere((t) => t.id == id);
    
    if (index != -1) {
      // Toggle status
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      
      // Update di database
      await _hiveService.updateTask(_tasks[index]);
      
      // Jika sudah completed, cancel reminder
      if (_tasks[index].isCompleted) {
        await _notificationService.cancelTaskReminder(id);
      } else {
        // Jika di-uncomplete, schedule lagi
        await _notificationService.scheduleTaskReminder(_tasks[index]);
      }
      
      // Beritahu UI
      notifyListeners();
    }
  }

  // Reorder tasks (untuk drag & drop)
  Future<void> reorderTasks(int oldIndex, int newIndex) async {
    // Adjust newIndex jika item dipindah ke bawah
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    // Ambil task yang dipindah
    final task = _tasks.removeAt(oldIndex);
    
    // Insert di posisi baru
    _tasks.insert(newIndex, task);

    // Update order semua tasks
    for (int i = 0; i < _tasks.length; i++) {
      _tasks[i].order = i;
      await _hiveService.updateTask(_tasks[i]);
    }

    // Beritahu UI
    notifyListeners();
  }

  // Set filter kategori
  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners(); // Update UI dengan filter baru
  }

  // Set filter prioritas
  void setPriority(String priority) {
    _selectedPriority = priority;
    notifyListeners();
  }

  // Toggle filter completed only
  void toggleCompletedFilter() {
    _showCompletedOnly = !_showCompletedOnly;
    notifyListeners();
  }

  // Clear semua filter
  void clearFilters() {
    _selectedCategory = 'All';
    _selectedPriority = 'All';
    _showCompletedOnly = false;
    notifyListeners();
  }

  // Private method untuk mendapatkan tasks yang sudah difilter
  List<Task> _getFilteredTasks() {
    List<Task> filtered = List.from(_tasks); // Copy list

    // Filter berdasarkan kategori
    if (_selectedCategory != 'All') {
      filtered = filtered
          .where((task) => task.category == _selectedCategory)
          .toList();
    }

    // Filter berdasarkan prioritas
    if (_selectedPriority != 'All') {
      filtered = filtered
          .where((task) => task.priority == _selectedPriority)
          .toList();
    }

    // Filter berdasarkan status completed
    if (_showCompletedOnly) {
      filtered = filtered.where((task) => task.isCompleted).toList();
    }

    return filtered;
  }

  // Hapus semua tasks (untuk fitur clear all)
  Future<void> deleteAllTasks() async {
    await _hiveService.deleteAllTasks();
    await _notificationService.cancelAllReminders();
    _tasks.clear();
    notifyListeners();
  }

  // Get tasks by date (untuk fitur calendar)
  List<Task> getTasksByDate(DateTime date) {
    return _tasks.where((task) {
      final taskDate = task.deadline;
      return taskDate.year == date.year &&
          taskDate.month == date.month &&
          taskDate.day == date.day;
    }).toList();
  }
}