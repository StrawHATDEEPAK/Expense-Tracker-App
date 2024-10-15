import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/domain/usecases/user_usecases/login_usecase.dart';
import 'package:personal_expense_tracker/domain/usecases/user_usecases/logout.dart';
import 'package:personal_expense_tracker/domain/usecases/user_usecases/register_usecase.dart';

import '../notifications/notification_service.dart';

class UserProvider extends ChangeNotifier {
  final LoginUseCase loginUseCase;
  final SignupUseCase signupUseCase;
  final LogoutUseCase logoutUseCase;

  UserProvider(
      {required this.loginUseCase,
      required this.signupUseCase,
      required this.logoutUseCase});

  bool _isLoading = false;
  String _errorMessage = '';
  bool _isLoggedIn = false;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      await loginUseCase.call(email, password);
      _isLoggedIn = true;
      await NotificationService().scheduleDailyNotification();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signup(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      await signupUseCase.call(name, email, password);
      _isLoggedIn = true;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await logoutUseCase.call();
      _isLoggedIn = false;
      await NotificationService().cancelAllNotifications();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
