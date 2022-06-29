
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


void main() {

  late final Client client;
  late final HttpAdapter sut;
  late final String url;
  late final Map<String, String> headers;

  setUp(() {
    //Arrange
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
    headers = {
      "content-type": "application/json",
      "accept": "application/json",
    };
  });

    group('post', () {
      test('should call post with correct values', () async {
        when(() => client.post(Uri.parse(url), headers: headers)).thenAnswer((_) async => Response('body', 401));

        //Act
        await sut.request(url: url, method: 'post');

        //Expected
        verify(() => client.post(Uri.parse(url), headers: headers));
      });
    });
}