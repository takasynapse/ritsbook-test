import 'package:projectritsbook_native/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future login(String email, String password) async {
    await _authRepository.login(email, password);
  }
}
