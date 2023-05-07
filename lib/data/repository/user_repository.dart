import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectritsbook_native/data/data_sources/user_remote_data_source.dart';
import 'package:projectritsbook_native/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;

  UserRepositoryImpl({required UserRemoteDataSource userRemoteDataSource})
      : _userRemoteDataSource = userRemoteDataSource;

  @override
  Future<User> getUserId() async {
    return await _userRemoteDataSource.getUserId();
  }
}