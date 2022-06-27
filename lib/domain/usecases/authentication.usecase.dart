import '../entities/entities.exports.dart';

abstract class AuthenticationUseCase{
  Future<AccountEntity> auth({required String email, required String password});
}