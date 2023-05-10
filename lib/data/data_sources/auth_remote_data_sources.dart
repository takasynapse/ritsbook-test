abstract class AuthRemoteDataSource {
  Future login(String email, String password);
  Future signUp(String email, String password);
}
