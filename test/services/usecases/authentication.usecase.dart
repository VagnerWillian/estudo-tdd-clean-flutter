import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:estudo_clean_tdd_flutter/domain/usecases/authentication.usecase.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;
  RemoteAuthentication({required this.httpClient, required this.url});

  Future<void>? auth(AuthenticationParams params)async{
    final body = {"email":params.email, "password":params.secretPass};
    return await httpClient.request(url: url, method: 'post', body: body);
  }
}

abstract class HttpClient{
  Future<void>? request({required String url, required String method, Map? body})async{
    return;
  }
}

class HttpClientSpy extends Mock implements HttpClient{}

void main(){

  late HttpClient httpClient;
  late String url;
  late RemoteAuthentication sut;

  setUp((){
      //Arrange
      httpClient = HttpClientSpy();
      url = faker.internet.httpsUrl();
      sut = RemoteAuthentication(httpClient: httpClient, url: url);
    }
  );

  test('Should call HttpClient with correct values', ()async{
   final params = AuthenticationParams(email: faker.internet.email(), secretPass: faker.internet.password());

  //Act
  sut.auth(params);

  //Assert
    verify(httpClient.request(
        url: url,
        method: 'post',
        body: {
          'email': params.email,
          'password': params.secretPass
        }
    ));
  });
}