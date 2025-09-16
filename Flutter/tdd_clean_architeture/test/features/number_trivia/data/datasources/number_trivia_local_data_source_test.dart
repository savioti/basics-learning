import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_flutter_clean_architeture/core/error/exceptions/cache_exception.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/data/datasources/number_trivia_local_data_source_impl.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  late final NumberTriviaLocalDataSourceImplementation localDataSource;
  late final SharedPreferences sharedPreferences;
  const cachedNumberTriviaKey =
      NumberTriviaLocalDataSourceImplementation.cachedNumberTriviaKey;
  final stringfiedJson = fixture('trivia_cached.json');
  final decodedJson = json.decode(stringfiedJson);
  final tNumberTriviaModel = NumberTriviaModel.fromJson(decodedJson);

  setUpAll(() async {
    localDataSource = NumberTriviaLocalDataSourceImplementation();
    sharedPreferences = await SharedPreferences.getInstance();
  });

  group('getLastNumberTrivia', () {
    test('should return NumberTrivia when there\'s one in the local storage',
        () async {
      final preferencesValue =
          sharedPreferences.getString(cachedNumberTriviaKey);

      if (preferencesValue == null) {
        sharedPreferences.setString(cachedNumberTriviaKey, stringfiedJson);
        expect(sharedPreferences.getString(cachedNumberTriviaKey),
            equals(stringfiedJson));
      }

      final lastTrivia = await localDataSource.getLastNumberTrivia();

      if (preferencesValue == null) {
        sharedPreferences.remove(cachedNumberTriviaKey);
        expect(
            sharedPreferences.getString(cachedNumberTriviaKey), equals(null));
      }

      expect(lastTrivia, tNumberTriviaModel);
    });

    test(
        'should throw a CacheException when there\'s not a NumberTrivia cached',
        () async {
      final backedUpValue = sharedPreferences.getString(cachedNumberTriviaKey);

      if (backedUpValue != null) {
        sharedPreferences.remove(cachedNumberTriviaKey);
        expect(
            sharedPreferences.getString(cachedNumberTriviaKey), equals(null));
      }

      final functionCall = localDataSource.getLastNumberTrivia;
      await expectLater(functionCall, throwsA(isA<CacheException>()));

      if (backedUpValue != null) {
        sharedPreferences.setString(cachedNumberTriviaKey, backedUpValue);
        expect(
            sharedPreferences.getString(cachedNumberTriviaKey), backedUpValue);
      }
    });
  });

  group('cacheNumberTrivia', () {
    test('should call SharedPreferences to cache the data', () async {
      final backedUpValue = sharedPreferences.getString(cachedNumberTriviaKey);

      if (backedUpValue != null) {
        sharedPreferences.remove(cachedNumberTriviaKey);
        expect(
            sharedPreferences.getString(cachedNumberTriviaKey), equals(null));
      }

      await localDataSource.cacheNumber(tNumberTriviaModel);
      final mappedCachedString =
          sharedPreferences.getString(cachedNumberTriviaKey);
      expect(mappedCachedString, isNot(equals(null)));
      final cachedMap = Map.from(jsonDecode(mappedCachedString!));
      expect(cachedMap, tNumberTriviaModel.toJson());

      if (backedUpValue != null) {
        sharedPreferences.setString(cachedNumberTriviaKey, backedUpValue);
        expect(
            sharedPreferences.getString(cachedNumberTriviaKey), backedUpValue);
      }
    });
  });
}
