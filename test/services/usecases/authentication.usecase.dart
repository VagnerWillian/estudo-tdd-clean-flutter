import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
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
      httpClient = HttpClientSpy();
      url = faker.internet.httpsUrl();
      sut = RemoteAuthentication(httpClient: httpClient, url: url);
      params = AuthenticationParams(email: faker.internet.email(), secretPass: faker.internet.password());
  }
  );

  test('Should call HttpClient with correct values', ()async{
    //Arrange
    when(()=>httpClient.request(url: any(named: 'url'), method: any(named: 'method'), body: any(named: 'body')))
        .thenAnswer((_)async=>{'accessToken': faker.guid.guid(), 'name': faker.person.name()});

  //Act
  sut.auth(params);

  //Assert
    verify(()=>httpClient.request(
        url: url,
        method: 'post',
        body: {
          'email': params.email,
          'password': params.secretPass
        }
    ));
  });

  test('Should throw UnexpectedError if HttpClient returns 400', ()async{
    //Arrange
    when(()=> httpClient.request(url: any(named: 'url'), method: any(named: 'method'), body: any(named: 'body')))
        .thenThrow(HttpError.badRequest);

    //Act
    final future = sut.auth(params);

    //Assert
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', ()async{
    //Arrange
    when(()=>httpClient.request(url: any(named: 'url'), method: any(named: 'method'), body: any(named: 'body')))
        .thenThrow(HttpError.notFound);

    //Act
    final future = sut.auth(params);

    //Assert
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', ()async{
    //Arrange
    when(()=>httpClient.request(url: any(named: 'url'), method: any(named: 'method'), body: any(named: 'body')))
        .thenThrow(HttpError.serverError);

    //Act
    final future = sut.auth(params);

    //Assert
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentialsError error if HttpClient returns 500', ()async{
    //Arrange
    when(()=>httpClient.request(url: any(named: 'url'), method: any(named: 'method'), body: any(named: 'body')))
        .thenThrow(HttpError.unauthorized);

    //Act
    final future = sut.auth(params);

    //Assert
    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('Should return an Account if HttpClient returns 200', ()async{
    //Arrange
    final accessToken = faker.guid.guid();
    when(()=>httpClient.request(url: any(named: 'url'), method: any(named: 'method'), body: any(named: 'body')))
        .thenAnswer((_)async=>{'accessToken': accessToken, 'name': faker.person.name()});

    //Act
    final account = await sut.auth(params);

    //Assert
    expect(account.token, accessToken);
  });

  test('Should throw UnexpectedError if HttpClient returns 200 with invalid data', ()async{
    //Arrange
    when(()=>httpClient.request(url: any(named: 'url'), method: any(named: 'method'), body: any(named: 'body')))
        .thenAnswer((_)async=>{'invalid_key': "invalid_value"});

    //Act
    final future = sut.auth(params);

    //Assert
    expect(future, throwsA(DomainError.unexpected));
  });
}