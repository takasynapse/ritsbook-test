import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectritsbook_native/domain/entities/user_model/user_model.dart';

abstract class AuthRepository {
  ///ログイン(レポジトリ)
  Future login(String email, String password);

  ///新規登録(レポジトリ)
  Future signUp(String email, String password);

  ///FireStoreにユーザー情報を登録する(レポジトリ)
  Future addUser(String uid, UserData userData);

  ///ログイン状態を確認する(レポジトリ)
  User? getCurrentUser();

  ///自身のユーザー情報を取得する(レポジトリ)
  Future<UserData> getUserData(String uid);
}
