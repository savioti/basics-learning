import 'package:dartz/dartz.dart';
import 'package:study_flutter_clean_architeture/core/error/failures/failure.dart';
import 'package:study_flutter_clean_architeture/core/error/failures/invalid_input_failure.dart';

class InputConverter {
  Either<Failure, int> unsignedIntFromString(String input) {
    var parsedValue = 0;

    try {
      parsedValue = int.parse(input);

      if (parsedValue < 0) {
        throw const FormatException();
      }

      return Right(parsedValue);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}
