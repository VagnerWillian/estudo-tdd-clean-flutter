abstract class LoginPresenter{
  Stream<String?> get emailErrorStream;
  Stream<String?> get passwordErrorStream;
  Stream<bool> get enableButtonStream;
  Stream<bool> get visibleLoadingStream;

  void validateEmail(String email);
  void validatePassword(String pass);
  void auth();
}