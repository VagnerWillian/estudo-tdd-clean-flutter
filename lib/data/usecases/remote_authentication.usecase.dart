import '../../domain/usecases/authentication.usecase.dart';
import '../http/http.exports.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;
  RemoteAuthentication({required this.httpClient, required this.url});

  Future<void>? auth(AuthenticationParams params)async{
    return await httpClient.request(url: url, method: 'post', body: RemoteAuthenticationParams.fromDomain(params).toJson);
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