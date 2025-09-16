import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:study_flutter_clean_architeture/core/error/exceptions/server_exception.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/data/models/number_trivia_model.dart';

class NumberTriviaRemoteDataSourceImplementation
    implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImplementation({required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    final uri = Uri.parse('http://numbersapi.com/$number');
    final numberTrivia = await _getTriviaFromUri(uri);
    return numberTrivia;
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    final uri = Uri.parse('http://numbersapi.com/random');
    final numberTrivia = await _getTriviaFromUri(uri);
    return numberTrivia;
  }

  Future<NumberTriviaModel> _getTriviaFromUri(Uri uri) async {
    final response = await client.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }

    final responseJson = json.decode(response.body);
    return NumberTriviaModel.fromJson(responseJson);
  }
}
