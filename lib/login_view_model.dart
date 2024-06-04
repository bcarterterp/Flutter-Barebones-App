import 'package:flutter/material.dart';
import 'package:flutter_sa_onsite/login_state.dart';

class LoginViewModel extends ChangeNotifier {
  LoginState _currentState = const LoginInitial();

  LoginState get state => _currentState;

  void login(String username, String password) async {
    _currentState = const LoginLoading();
    notifyListeners();
    await Future.delayed(const Duration(seconds: 3));
    _currentState = const LoginSuccess();
    notifyListeners();
  }
}
