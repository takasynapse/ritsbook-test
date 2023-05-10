import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectritsbook_native/domain/entities/user_model.dart';
import 'package:projectritsbook_native/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository _authRepository;

  SignUpUseCase(this._authRepository);

  Future<UserCredential> signUp(
      String email, String password, UserData userData) async {
    final userCredential = await _authRepository.signUp(email, password);
    await _authRepository.addUser(userCredential.user!.uid, userData);
    return userCredential;
  }
}
