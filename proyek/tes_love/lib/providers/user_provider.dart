import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../models/user_model.dart';
import '../utils/storage_service.dart';

class UserProvider extends ChangeNotifier {
  StorageService? _storage;
  List<UserModel> _users = [];
  UserModel? _activeUser;
  bool _isLoading = true;

  List<UserModel> get users => List.unmodifiable(_users);
  UserModel? get activeUser => _activeUser;
  bool get isLoading => _isLoading;
  bool get hasUsers => _users.isNotEmpty;

  Future<void> init() async {
    _storage = await StorageService.create();
    _users = await _storage!.getUsers();
    final activeId = _storage!.getActiveUserId();
    if (activeId != null) {
      try {
        _activeUser = _users.firstWhere((u) => u.id == activeId);
      } catch (_) {
        _activeUser = null;
      }
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addUser(String name) async {
    if (name.trim().isEmpty) return;
    final user = UserModel(
      id: const Uuid().v4(),
      name: name.trim(),
      createdAt: DateTime.now(),
    );
    await _storage!.saveUser(user);
    _users = await _storage!.getUsers();
    notifyListeners();
  }

  Future<void> setActiveUser(UserModel user) async {
    _activeUser = user;
    await _storage!.setActiveUserId(user.id);
    notifyListeners();
  }

  Future<void> deleteUser(UserModel user) async {
    await _storage!.deleteUser(user.id);
    _users = await _storage!.getUsers();
    if (_activeUser?.id == user.id) {
      _activeUser = null;
    }
    notifyListeners();
  }

  void logout() {
    _activeUser = null;
    _storage?.setActiveUserId(null);
    notifyListeners();
  }
}