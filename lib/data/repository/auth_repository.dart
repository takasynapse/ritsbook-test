import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectritsbook_native/data/data_sources/auth_data_source.dart';

class AuthRepository{
  final AuthDataSource _authDataSource;

  AuthRepository({required AuthDataSource authDataSource})
      : _authDataSource = authDataSource;

  User? getCurrentUser() {
    return _authDataSource.getCurrentUser();
  }
}