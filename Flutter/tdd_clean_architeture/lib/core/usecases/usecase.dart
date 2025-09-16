import 'package:dartz/dartz.dart';
import 'package:study_flutter_clean_architeture/core/error/failures/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
