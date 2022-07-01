abstract class LoginPresenter{
  Stream<String?> get emailErrorStream;
  Stream<String?> get passwordErrorStream;
  Stream<bool> get enableButtonStream;
  Stream<bool> get visibleLoadingStream;
  Stream<String?> get mainErrorStream;

  void validateEmail(String email);
  void validatePassword(String pass);
  void auth();
  void dispose();
}