import '../entities/entities.exports.dart';

abstract class AuthenticationUseCase{
  Future<AccountEntity> auth(AuthenticationParams params);
}

class AuthenticationParams{
  final String email, secretPass;
  AuthenticationParams({required this.email, required this.secretPass});
}