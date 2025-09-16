import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:study_flutter_clean_architeture/core/error/exceptions/cache_exception.dart';
import 'package:study_flutter_clean_architeture/core/error/exceptions/server_exception.dart';
import 'package:study_flutter_clean_architeture/core/error/failures/cache_failure.dart';
import 'package:study_flutter_clean_architeture/core/error/failures/server_failure.dart';
import 'package:study_flutter_clean_architeture/core/network/network_info.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/domain/entities/number_trivia.dart';

import 'number_trivia_repository_impl_test.mocks.dart';

@GenerateMocks([
  NumberTriviaRemoteDataSource,
  NumberTriviaLocalDataSource,
  NetworkInfo,
])
void main() {
  late final MockNumberTriviaRemoteDataSource remoteDataSource;
  late final MockNumberTriviaLocalDataSource localDataSource;
  late final MockNetworkInfo networkInfo;
  late final NumberTriviaRepositoryImpl repository;
  const tNumber = 1;
  const tNumberTriviaModel = NumberTriviaModel(
    number: tNumber,
    text: 'test trivia',
  );
  const NumberTrivia tNumberTrivia = tNumberTriviaModel;

  setUpAll(() {
    remoteDataSource = MockNumberTriviaRemoteDataSource();
    localDataSource = MockNumberTriviaLocalDataSource();
    networkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
      networkInfo: networkInfo,
    );

    when(remoteDataSource.getConcreteNumberTrivia(any))
        .thenAnswer((_) async => tNumberTriviaModel);
    when(remoteDataSource.getRandomNumberTrivia())
        .thenAnswer((_) async => tNumberTriviaModel);
  });

  group('getConcreteNumberTrivia', () {
    test('should check if the device is connected', () async {
      when(networkInfo.isConnected).thenAnswer((_) async => true);

      await repository.getConcreteNumberTrivia(tNumber);
      verify(networkInfo.isConnected);
    });

    group('test when device is online', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        when(remoteDataSource.getConcreteNumberTrivia(1))
            .thenAnswer((_) async => tNumberTriviaModel);
        final result = await repository.getConcreteNumberTrivia(tNumber);
        verify(remoteDataSource.getConcreteNumberTrivia(tNumber));
        expect(result, equals(const Right(tNumberTrivia)));
      });

      test(
          'should cache the data locally when the call to remote data source is successful',
          () async {
        when(remoteDataSource.getConcreteNumberTrivia(1))
            .thenAnswer((_) async => tNumberTriviaModel);
        await repository.getConcreteNumberTrivia(tNumber);
        verify(remoteDataSource.getConcreteNumberTrivia(tNumber));
        verify(localDataSource.cacheNumber(tNumberTriviaModel));
      });

      test(
          'should return server failure when the call to remote data source is not successful',
          () async {
        when(remoteDataSource.getConcreteNumberTrivia(1))
            .thenThrow(ServerException());
        final result = await repository.getConcreteNumberTrivia(tNumber);
        verify(remoteDataSource.getConcreteNumberTrivia(tNumber));
        verifyNoMoreInteractions(localDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    group('test when device is offline', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
          'should cache the data locally when the call to remote data source is successful',
          () async {
        when(localDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);

        final result = await repository.getConcreteNumberTrivia(tNumber);

        verifyNoMoreInteractions(remoteDataSource);
        verify(localDataSource.getLastNumberTrivia());
        expect(result, equals(const Right(tNumberTrivia)));
      });

      test('should return CacheFailure when there is no cached data present ',
          () async {
        when(localDataSource.getLastNumberTrivia()).thenThrow(CacheException());
        final result = await repository.getConcreteNumberTrivia(tNumber);

        verifyNoMoreInteractions(remoteDataSource);
        verify(localDataSource.getLastNumberTrivia());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });

  group('getRandomNumberTrivia', () {
    test('should check if the device is connected', () async {
      when(networkInfo.isConnected).thenAnswer((_) async => true);

      await repository.getRandomNumberTrivia();
      verify(networkInfo.isConnected);
    });

    group('test when device is online', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        when(remoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        final result = await repository.getRandomNumberTrivia();
        verify(remoteDataSource.getRandomNumberTrivia());
        expect(result, equals(const Right(tNumberTrivia)));
      });

      test(
          'should cache the data locally when the call to remote data source is successful',
          () async {
        when(remoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        await repository.getRandomNumberTrivia();
        verify(remoteDataSource.getRandomNumberTrivia());
        verify(localDataSource.cacheNumber(tNumberTriviaModel));
      });

      test(
          'should return server failure when the call to remote data source is not successful',
          () async {
        when(remoteDataSource.getRandomNumberTrivia())
            .thenThrow(ServerException());
        final result = await repository.getRandomNumberTrivia();
        verify(remoteDataSource.getRandomNumberTrivia());
        verifyNoMoreInteractions(localDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    group('test when device is offline', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
          'should cache the data locally when the call to remote data source is successful',
          () async {
        when(localDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);

        final result = await repository.getRandomNumberTrivia();

        verifyNoMoreInteractions(remoteDataSource);
        verify(localDataSource.getLastNumberTrivia());
        expect(result, equals(const Right(tNumberTrivia)));
      });

      test('should return CacheFailure when there is no cached data present ',
          () async {
        when(localDataSource.getLastNumberTrivia()).thenThrow(CacheException());
        final result = await repository.getRandomNumberTrivia();

        verifyNoMoreInteractions(remoteDataSource);
        verify(localDataSource.getLastNumberTrivia());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
