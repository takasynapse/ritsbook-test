import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRemoteDataSource {
  Future<User> getUserId();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  UserRemoteDataSourceImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User> getUserId() async {
    final user = _firebaseAuth.currentUser!;
    return user;
  }
}