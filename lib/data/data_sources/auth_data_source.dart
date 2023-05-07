import 'package:firebase_auth/firebase_auth.dart';

class AuthDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  AuthDataSource(_firebaseAuth);

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}
