import 'package:dartz/dartz.dart';
import 'package:study_flutter_clean_architeture/core/error/failures/failure.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);

  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
