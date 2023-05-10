import 'package:flutter/material.dart';
import 'package:projectritsbook_native/domain/entities/user_model.dart';
import 'package:projectritsbook_native/domain/usecases/auth/sign_up_use_case.dart';

class SignUpViewModel extends ChangeNotifier{
  final SignUpUseCase _signUpUseCase;

  SignUpViewModel(this._signUpUseCase);

  Future signUp(String email, String password, UserData userData) async {
    await _signUpUseCase.signUp(email, password, userData);
  }
}