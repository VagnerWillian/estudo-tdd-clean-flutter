abstract class LoginPresenter{
  Stream<String?> get emailErrorStream;
  Stream<String?> get passwordErrorStream;
  Stream<String?> get mainErrorStream;
  Stream<bool> get enableButtonStream;
  Stream<bool> get visibleLoadingStream;

  void validateEmail(String email);
  void validatePassword(String pass);
  Future<void> auth();
  void dispose();
}