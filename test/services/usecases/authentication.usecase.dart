import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;
  RemoteAuthentication({required this.httpClient, required this.url});

  Future<void>? auth()async{
    return await httpClient.request(url: url, method: 'post');
  }
}

abstract class HttpClient{
  Future<void>? request({required String url, required String method})async{
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

  //Act
  sut.auth();

  //Assert
    verify(httpClient.request(
        url: url,
        method: 'post'
    ));
  });
}