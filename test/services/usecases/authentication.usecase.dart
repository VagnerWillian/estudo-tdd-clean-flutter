import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:estudo_clean_tdd_flutter/data/http/http.exports.dart';
import 'package:estudo_clean_tdd_flutter/data/usecases/usecases.exports.dart';
import 'package:estudo_clean_tdd_flutter/domain/usecases/usecases.exports.dart';
import 'package:estudo_clean_tdd_flutter/helpers/helpers.exports.dart';

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

  test('Should throw UnexpectedError if HttpClient returns 400', ()async{
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
        .thenThrow(HttpError.badRequest);
    final params = AuthenticationParams(email: faker.internet.email(), secretPass: faker.internet.password());

    //Act
    final future = sut.auth(params);

    //Assert
    expect(future, throwsA(DomainError.unexpected));
  });
}