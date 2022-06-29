
import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class ClientSpy extends Mock implements Client{}
class HttpAdapter{
  final Client client;
  HttpAdapter(this.client);
  Future<void> request({required String url, required String method})async{
    final headers = {
      "content-type": "application/json",
      "accept": "application/json",
    };
    await client.post(Uri.parse(url), headers: headers);
  }
}

setup(){

}

main(){
  group('post', () {
    test('should call post with correct values', () async{

      //Arrange
      final client = ClientSpy();
      final sut = HttpAdapter(client);
      final url = faker.internet.httpUrl();
      final headers = {
      "content-type": "application/json",
      "accept": "application/json",
      };
      when(()=>client.post(Uri.parse(url), headers: headers)).thenAnswer((_) async => Response('body', 401));

      //Act
      await sut.request(url: url, method: 'post');

      //Expected
      verify(()=>client.post(Uri.parse(url), headers: headers));
    });
  });
}