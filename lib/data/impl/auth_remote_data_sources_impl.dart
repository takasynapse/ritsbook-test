import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectritsbook_native/data/data_sources/auth_remote_data_sources.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  
  AuthRemoteDataSourceImpl(this._firebaseAuth);

  ///ログインメソッド
  @override
  Future<UserCredential> login(String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  ///サインアップメソッド
  @override
  Future<UserCredential> signUp(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
