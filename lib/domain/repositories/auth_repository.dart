import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectritsbook_native/domain/entities/user_model.dart';

abstract class AuthRepository {
  ///ログイン(レポジトリ)
  Future login(String email, String password);

  ///新規登録(レポジトリ)
  Future signUp(String email, String password);

  ///FireStoreにユーザー情報を登録する(レポジトリ)
  Future addUser(String uid, UserData userData);
}
