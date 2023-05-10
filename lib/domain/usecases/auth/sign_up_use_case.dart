import 'package:projectritsbook_native/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository _authRepository;
  
  SignUpUseCase(this._authRepository);

  Future signUp(String email, String password) async {
    await _authRepository.signUp(email, password);
  }
}