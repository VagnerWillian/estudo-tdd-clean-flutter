import 'package:estudo_clean_tdd_flutter/helpers/http_error.dart';
import 'package:estudo_clean_tdd_flutter/infra/http/http.exports.dart';
import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class ClientSpy extends Mock implements Client{}

void main() {

  late Client client;
  late HttpAdapter sut;
  late String url;
  late Map<String, String> headers;
  late Map<String, String> body;

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

      When mockRequest()=>when(() => client.post(Uri.parse(url), headers: any(named: 'headers'), body: any(named: 'body')));
      void mockResponse({int statusCode = 500, String body = '{"any_key":"any_value"}'}){
        mockRequest().thenAnswer((_)async=>Response(body, statusCode));
      }

      setUp((){
        mockResponse(statusCode: 200);
      });

      test('should call post with correct values', () async {
        //Act
        await sut.request(url: url, method: 'post', body: body);

        //Expected
        verify(() => client.post(Uri.parse(url), headers: headers, body: body));
      });

      test('should call post without body', () async {
        //Act
        await sut.request(url: url, method: 'post');

        //Expected
        verify(() => client.post(Uri.parse(url), headers: headers));
      });

      test('should return data if post returns 200', () async {
        //Act
        final response = await sut.request(url: url, method: 'post');

        //Expected
        expect(response, {'any_key':'any_value'});
      });

      test('should return null if post returns 200', () async {
        mockResponse(statusCode: 200, body: '');

        //Act
        final response = await sut.request(url: url, method: 'post');

        //Expected
        expect(response, null);
      });

      test('should return null if post returns 204', () async {
        mockResponse(statusCode: 204, body: '');

        //Act
        final response = await sut.request(url: url, method: 'post');

        //Expected
        expect(response, null);
      });

      test('should return null if post returns 204 with data', () async {
        mockResponse(statusCode: 204);

        //Act
        final response = await sut.request(url: url, method: 'post');

        //Expected
        expect(response, null);
      });

      test('should return BadRequestError if post returns 400', () async {
        mockResponse(statusCode: 400);

        //Act
        final future = sut.request(url: url, method: 'post');

        //Expected
        expect(future, throwsA(HttpError.badRequest));
      });

      test('should return BadRequestError if post returns 400 without body', () async {
        mockResponse(statusCode: 400, body: '');

        //Act
        final future = sut.request(url: url, method: 'post');

        //Expected
        expect(future, throwsA(HttpError.badRequest));
      });
    });
}