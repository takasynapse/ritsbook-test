abstract class AuthRepository {
  ///ログイン(レポジトリ)
  Future login(String email, String password);
  ///新規登録(レポジトリ)
  Future signUp(String email, String password);
}
