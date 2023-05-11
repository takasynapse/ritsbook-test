import 'package:projectritsbook_native/domain/entities/user_model.dart';
import 'package:projectritsbook_native/domain/repositories/auth_repository.dart';

class GetUserDataUseCase {
  final AuthRepository _authRepository;

  GetUserDataUseCase(this._authRepository);

  Future<UserData> call(String uid) async {
    return await _authRepository.getUserData(uid);
  }
}