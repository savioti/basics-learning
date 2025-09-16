import 'package:equatable/equatable.dart';
import 'package:study_flutter_clean_architeture/core/error/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:study_flutter_clean_architeture/core/usecases/usecase.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  const GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(params) async {
    return await repository.getRandomNumberTrivia();
  }
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
