import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectritsbook_native/core/firestore_crud_operations.dart';
import 'package:projectritsbook_native/data/repository/user_remote_data_model.dart';
import 'package:projectritsbook_native/domain/entities/user_model/user_model.dart';

class AuthRemoteDataSource
    extends FirestoreCrudOperations<UserRemoteDataModel> {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  AuthRemoteDataSource({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
  })  : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore,
        super(
          'users',
          (doc) => UserRemoteDataModel.fromFireStoreDocument(doc),
        );

  User getLoggedInUser() {
    final user = _firebaseAuth.currentUser;
    return user!;
  }

  ///サインアップメソッド
  Future<User?> signUp(
    String email,
    String password,
  ) async {
    try {
      final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user!;
      await Future.wait([
        super.add(
          UserRemoteDataModel(
            id: user.uid,
            email: user.email!,
          ),
        ),
      ]);
      return result.user!;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw Exception();
        case 'invalid-email':
          throw Exception();
        case 'operation-not-allowed':
          throw Exception();
      }
    }
    return null;
  }

  Future login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw Exception();
        case 'user-disabled':
          throw Exception();
        case 'user-not-found':
          throw Exception();
        case 'wrong-password':
          throw Exception();
      }
    }
  }

  // ///FireStoreにユーザー情報を登録するメソッド
  Future addUser(String uid, UserData userData) async {
    return await _firebaseFirestore
        .collection('users')
        .doc(uid)
        .set(userData.toJson());
  }

  ///ログイン状態を確認するメソッド
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  ///自身のユーザー情報を取得するメソッド
  Future<UserData> getUserData(String uid) async {
    final DocumentSnapshot doc =
        await _firebaseFirestore.collection('users').doc(uid).get();
    final data = doc.data() as Map<String, dynamic>;
    return UserData.fromJson(data);
  }
}
