abstract class LoginPresenter{
  Stream<String?> get emailErrorStream;
  Stream<String?> get passwordErrorStream;
  Stream<bool> get enableButtonStream;

  void validateEmail(String email);
  void validatePassword(String pass);
  void auth();
}