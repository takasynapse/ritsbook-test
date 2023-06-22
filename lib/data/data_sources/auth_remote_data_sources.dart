import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectritsbook_native/domain/entities/user_model/user_model.dart';

///認証系のリモートデータソースの抽象クラス
abstract class AuthRemoteDataSource {
  Future login(String email, String password);
  Future signUp(String email, String password);
  Future addUser(String uid, UserData userData);
  User? getCurrentUser();
  Future<UserData> getUserData(String uid);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AuthRemoteDataSourceImpl(this._firebaseAuth, this._firebaseFirestore);

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
  Future<UserCredential> signUp(String email, String password,) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  ///FireStoreにユーザー情報を登録するメソッド
  @override
  Future addUser(String uid, UserData userData) async {
    return await _firebaseFirestore.collection('users').doc(uid).set(userData.toJson());
  }

  ///ログイン状態を確認するメソッド
  @override
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

///自身のユーザー情報を取得するメソッド
  @override
  Future<UserData> getUserData(String uid) async {
    final DocumentSnapshot doc = await _firebaseFirestore.collection('users').doc(uid).get();
    final data = doc.data() as Map<String, dynamic>;
    return UserData.fromJson(data);
  }
}
