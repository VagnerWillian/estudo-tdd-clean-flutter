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
  late AuthenticationParams params;

  setUp((){
      //Arrange
      httpClient = HttpClientSpy();
      url = faker.internet.httpsUrl();
      sut = RemoteAuthentication(httpClient: httpClient, url: url);
      params = AuthenticationParams(email: faker.internet.email(), secretPass: faker.internet.password());
  }
  );

  test('Should call HttpClient with correct values', ()async{
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

    //Act
    final future = sut.auth(params);

    //Assert
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', ()async{
    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
        .thenThrow(HttpError.notFound);

    //Act
    final future = sut.auth(params);

    //Assert
    expect(future, throwsA(DomainError.unexpected));
  });
}