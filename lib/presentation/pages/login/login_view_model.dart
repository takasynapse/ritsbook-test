import 'package:flutter/material.dart';
import 'package:projectritsbook_native/domain/usecases/auth/login_use_case.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  Future login(String email, String password) async {
    await _loginUseCase.login(email, password);
  }
}
