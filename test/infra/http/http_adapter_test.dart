
import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class ClientSpy extends Mock implements Client{}
class HttpAdapter{
  final Client client;
  HttpAdapter(this.client);
  Future<void> request({required String url, required String method, Map body = const {}})async{
    final headers = {
      "content-type": "application/json",
      "accept": "application/json",
    };
    await client.post(Uri.parse(url), headers: headers, body: body);
  }
}


void main() {

  late final Client client;
  late final HttpAdapter sut;
  late final String url;
  late final Map<String, String> headers;
  late final Map<String, String> body;

  setUp(() {
    //Arrange
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
    headers = {
      "content-type": "application/json",
      "accept": "application/json",
    };
    body = {
      "any_key": "any_value"
    };
  });

    group('post', () {
      test('should call post with correct values', () async {
        when(() => client.post(Uri.parse(url), headers: headers, body: body)).thenAnswer((_) async => Response('body', 401));

        //Act
        await sut.request(url: url, method: 'post', body: body);

        //Expected
        verify(() => client.post(Uri.parse(url), headers: headers, body: body));
      });
    });
}