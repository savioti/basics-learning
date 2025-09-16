import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_flutter_clean_architeture/core/error/exceptions/cache_exception.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/data/models/number_trivia_model.dart';

class NumberTriviaLocalDataSourceImplementation
    implements NumberTriviaLocalDataSource {
  static const String cachedNumberTriviaKey = 'CACHED_NUMBER_TRIVIA';
  @override
  Future<void> cacheNumber(NumberTriviaModel triviaModelToBeCached) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final stringfiedJson = jsonEncode(triviaModelToBeCached.toJson());
    sharedPreferences.setString(cachedNumberTriviaKey, stringfiedJson);
  }

  @override
  Future<NumberTriviaModel?> getLastNumberTrivia() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final stringfiedJson = sharedPreferences.getString(cachedNumberTriviaKey);

    if (stringfiedJson == null) {
      throw CacheException();
    }

    final decodedJson = json.decode(stringfiedJson);
    final numberTriviaModel = NumberTriviaModel.fromJson(decodedJson);
    return numberTriviaModel;
  }
}
