import 'package:estudo_clean_tdd_flutter/helpers/helpers.exports.dart';
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

    group('shared', () {
      test('should throw ServerError if invalid method is proveded', () async {
        //Act
        final future = sut.request(url: url, method: 'invalidMethod');

        //Expected
        expect(future, throwsA(HttpError.serverError));
      });
    });

    group('post', () {

      When mockRequest()=>when(() => client.post(Uri.parse(url), headers: any(named: 'headers'), body: any(named: 'body')));
      void mockResponse({int statusCode = 500, String body = '{"any_key":"any_value"}'}){
        mockRequest().thenAnswer((_)async=>Response(body, statusCode));
      }

      void mockError(){
        mockRequest().thenThrow(Exception());
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

      test('should return UnauthorizedError if post returns 401', () async {
        mockResponse(statusCode: 401);

        //Act
        final future = sut.request(url: url, method: 'post');

        //Expected
        expect(future, throwsA(HttpError.unauthorized));
      });

      test('should return ForbiddenError if post returns 403', () async {
        mockResponse(statusCode: 403);

        //Act
        final future = sut.request(url: url, method: 'post');

        //Expected
        expect(future, throwsA(HttpError.forbidden));
      });

      test('should return NotFoundError if post returns 404', () async {
        mockResponse(statusCode: 404);

        //Act
        final future = sut.request(url: url, method: 'post');

        //Expected
        expect(future, throwsA(HttpError.notFound));
      });

      test('should return ServerError if post returns 500 without body', () async {
        mockResponse(statusCode: 500);

        //Act
        final future = sut.request(url: url, method: 'post');

        //Expected
        expect(future, throwsA(HttpError.serverError));
      });

      test('should return ServerError if post throws', () async {
        mockError();

        //Act
        final future = sut.request(url: url, method: 'post');

        //Expected
        expect(future, throwsA(HttpError.serverError));
      });
    });
}