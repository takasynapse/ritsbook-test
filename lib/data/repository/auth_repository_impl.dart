import 'package:projectritsbook_native/data/data_sources/auth_remote_data_sources.dart';
import 'package:projectritsbook_native/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl({required AuthRemoteDataSource authRemoteDataSource})
      : _authRemoteDataSource = authRemoteDataSource;

  @override
  Future login(String email, String password) async {
    return await _authRemoteDataSource.login(email, password);
  }

  @override
  Future signUp(String email, String password) async {
    return await _authRemoteDataSource.signUp(email, password);
  }
}
