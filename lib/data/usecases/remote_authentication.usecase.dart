import 'package:estudo_clean_tdd_flutter/data/models/remote_account.model.dart';
import 'package:estudo_clean_tdd_flutter/helpers/helpers.exports.dart';
import '../../domain/usecases/authentication.usecase.dart';
import '../../domain/entities/entities.exports.dart';

import '../http/http.exports.dart';

class RemoteAuthentication implements AuthenticationUseCase {
  final HttpClient httpClient;
  final String url;
  RemoteAuthentication({required this.httpClient, required this.url});

  @override
  Future<AccountEntity> auth(AuthenticationParams params)async{
    final body = RemoteAuthenticationParams.fromDomain(params).toJson;
    try{
      final httpReponse = await httpClient.request(url: url, method: 'post', body: body);
      return RemoteAccountModel.fromJson(httpReponse).toEntity;
    }on HttpError catch(err){
      throw err == HttpError.unauthorized ?
      DomainError.invalidCredentials : DomainError.unexpected;
    }
  }
}

class RemoteAuthenticationParams {
  final String email, secretPass;
  RemoteAuthenticationParams({required this.email, required this.secretPass});

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params){
    return RemoteAuthenticationParams(email: params.email, secretPass: params.secretPass);
  }

  Map get toJson => {"email": email, "password": secretPass};
}