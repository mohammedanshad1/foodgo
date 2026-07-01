import 'package:flutter/material.dart';
import 'package:foodgo/service/api_service.dart';


class LoginViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool _isSuccess = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isSuccess => _isSuccess;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    _isSuccess = false;
    notifyListeners();

    try {
      final result = await ApiService.login(email, password);
      
      _isLoading = false;
      
      if (result['success']) {
        _isSuccess = true;
        _errorMessage = null;
        notifyListeners();
        return true;
      } else {
        _errorMessage = result['error'] ?? 'Login failed. Please try again.';
        _isSuccess = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'An unexpected error occurred.';
      _isSuccess = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void reset() {
    _isLoading = false;
    _errorMessage = null;
    _isSuccess = false;
    notifyListeners();
  }
}