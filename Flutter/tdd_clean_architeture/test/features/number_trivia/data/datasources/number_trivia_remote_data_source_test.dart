import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:study_flutter_clean_architeture/core/error/exceptions/server_exception.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/data/datasources/number_trivia_remote_data_source_impl.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late final NumberTriviaRemoteDataSourceImplementation remoteDataSource;
  late final MockClient mockHttpClient;
  const tNumber = 1;
  final stringfiedJson = fixture('trivia_cached.json');
  final decodedJson = json.decode(stringfiedJson);
  final tNumberTriviaModel = NumberTriviaModel.fromJson(decodedJson);

  setUpAll(() {
    mockHttpClient = MockClient();
    remoteDataSource = NumberTriviaRemoteDataSourceImplementation(
      client: mockHttpClient,
    );
  });

  void _setUpMockedHttpClientSuccess() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(
              fixture('trivia.json'),
              200,
            ));
  }

  void _setUpMockedHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(
              'Something went wrong',
              404,
            ));
  }

  group('getConcreteNumberTrivia', () {
    test(
        'should perform a GET request on a URL with number being the endpoint and with application/json header',
        () async {
      _setUpMockedHttpClientSuccess();
      remoteDataSource.getConcreteNumberTrivia(tNumber);

      final uri = Uri.parse('http://numbersapi.com/$tNumber');

      verify(mockHttpClient.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      ));
    });

    test('should return NumberTrivia when the response code is 200 (success)',
        () async {
      _setUpMockedHttpClientSuccess();
      final result = await remoteDataSource.getConcreteNumberTrivia(tNumber);
      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw a ServerException when the response code is not 200',
        () async {
      _setUpMockedHttpClientFailure404();
      final call = remoteDataSource.getConcreteNumberTrivia(tNumber);
      expectLater(call, throwsA(isA<ServerException>()));
    });
  });

  group('getRandomNumberTrivia', () {
    test(
        'should perform a GET request on a URL with number being the endpoint and with application/json header',
        () async {
      _setUpMockedHttpClientSuccess();
      remoteDataSource.getRandomNumberTrivia();

      final uri = Uri.parse('http://numbersapi.com/random');

      verify(mockHttpClient.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      ));
    });

    test('should return NumberTrivia when the response code is 200 (success)',
        () async {
      _setUpMockedHttpClientSuccess();
      final result = await remoteDataSource.getRandomNumberTrivia();
      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw a ServerException when the response code is not 200',
        () async {
      _setUpMockedHttpClientFailure404();
      final call = remoteDataSource.getRandomNumberTrivia();
      expectLater(call, throwsA(isA<ServerException>()));
    });
  });
}
