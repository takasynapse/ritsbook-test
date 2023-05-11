import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectritsbook_native/data/data_sources/auth_remote_data_sources.dart';
import 'package:projectritsbook_native/domain/entities/user_model.dart';
import 'package:projectritsbook_native/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl({required AuthRemoteDataSource authRemoteDataSource})
      : _authRemoteDataSource = authRemoteDataSource;

  ///ログインメソッド
  @override
  Future login(String email, String password) async {
    return await _authRemoteDataSource.login(email, password);
  }

  ///サインアップメソッド
  @override
  Future signUp(String email, String password) async {
    return await _authRemoteDataSource.signUp(email, password);
  }

  ///FireStoreにユーザー情報を登録するメソッド
  @override
  Future addUser(String uid, UserData userData) async {
    return await _authRemoteDataSource.addUser(uid, userData);
  }

  ///ログイン状態を確認するメソッド
  @override
  User? getCurrentUser() {
    return _authRemoteDataSource.getCurrentUser();
  }

  ///自身のユーザー情報を取得するメソッド
  @override
  Future<UserData> getUserData(String uid) async {
    return await _authRemoteDataSource.getUserData(uid);
  }
}
