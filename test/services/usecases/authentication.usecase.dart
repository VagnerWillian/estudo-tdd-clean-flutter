import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;
  RemoteAuthentication({required this.httpClient, required this.url});

  Future<void>? auth()async{
    return await httpClient.request(url: url);
  }
}

abstract class HttpClient{
  Future<void>? request({required String url})async{
    return;
  }
}

class HttpClientSpy extends Mock implements HttpClient{}

void main(){
  test('Should call HttpClient with correct URL', ()async{
  //Arrange
  final httpClient = HttpClientSpy();
  final url = faker.internet.httpsUrl();
  final sut = RemoteAuthentication(httpClient: httpClient, url: url);

  //Act
  sut.auth();

  //Assert
    verify(httpClient.request(url: url));
  });
}