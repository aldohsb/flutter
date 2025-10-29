import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../services/database_service.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasUser => _user != null;

  Future<void> loadUser() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _user = await DatabaseService.instance.getFirstUser();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createUser(UserModel user) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final id = await DatabaseService.instance.insertUser(user);
      if (id > 0) {
        _user = user.copyWith(
          id: id,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = 'Gagal menyimpan data ke database';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = 'Error: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      print('Error creating user: $e'); // Debug log
      return false;
    }
  }

  Future<bool> updateUser(UserModel user) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await DatabaseService.instance.updateUser(user);
      _user = user;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateCurrentWeight(double weight) async {
    if (_user == null) return false;

    final updatedUser = _user!.copyWith(
      currentWeight: weight,
      updatedAt: DateTime.now(),
    );

    return await updateUser(updatedUser);
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}