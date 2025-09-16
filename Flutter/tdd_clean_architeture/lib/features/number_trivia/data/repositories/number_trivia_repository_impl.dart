import 'package:study_flutter_clean_architeture/core/error/exceptions/cache_exception.dart';
import 'package:study_flutter_clean_architeture/core/error/exceptions/server_exception.dart';
import 'package:study_flutter_clean_architeture/core/error/failures/cache_failure.dart';
import 'package:study_flutter_clean_architeture/core/error/failures/server_failure.dart';
import 'package:study_flutter_clean_architeture/core/network/network_info.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:study_flutter_clean_architeture/core/error/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/domain/repositories/number_trivia_repository.dart';

typedef _TriviaRetrievingCall = Future<NumberTriviaModel> Function();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
    int number,
  ) async {
    final numberTrivia =
        await _getTrivia(() => _retrieveConcreteNumberTrivia(number));
    return numberTrivia;
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    final numberTrivia = await _getTrivia(() => _retrieveRandomNumberTrivia());
    return numberTrivia;
  }

  Future<NumberTriviaModel> _retrieveConcreteNumberTrivia(int number) async {
    final numberTrivia = await remoteDataSource.getConcreteNumberTrivia(number);
    return numberTrivia;
  }

  Future<NumberTriviaModel> _retrieveRandomNumberTrivia() async {
    final numberTrivia = await remoteDataSource.getRandomNumberTrivia();
    return numberTrivia;
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
      _TriviaRetrievingCall triviaRetrievingCall) async {
    final isConnected = await networkInfo.isConnected;

    try {
      if (isConnected) {
        final numberTrivia = await triviaRetrievingCall();
        localDataSource.cacheNumber(numberTrivia);
        return Right(numberTrivia);
      } else {
        final lastNumberTrivia = await localDataSource.getLastNumberTrivia();

        if (lastNumberTrivia == null) {
          throw CacheException();
        }

        return Right(lastNumberTrivia);
      }
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
