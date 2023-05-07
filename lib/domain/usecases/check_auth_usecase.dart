import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectritsbook_native/data/repository/auth_repository.dart';

class CheckAuthUseCase {
  final AuthRepository _authRepository;

  CheckAuthUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  User? call() {
    return _authRepository.getCurrentUser();
  }
}