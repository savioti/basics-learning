import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_flutter_clean_architeture/core/error/failures/invalid_input_failure.dart';
import 'package:study_flutter_clean_architeture/core/util/input_converter.dart';

void main() {
  late final InputConverter inputConverter;

  setUpAll(() async {
    inputConverter = InputConverter();
  });

  group('unsignedIntFromString', () {
    test(
        'should return an integer when the String represents an unsigned integer',
        () async {
      const input = '1';

      final result = inputConverter.unsignedIntFromString(input);

      expect(result, equals(const Right(1)));
    });

    test(
        'should return a Failure when the String cannot be parsed to a unsigned integer',
        () async {
      const input = 'string';

      final result = inputConverter.unsignedIntFromString(input);

      expect(result, Left(InvalidInputFailure()));
    });

    test(
        'should return a Failure when the String was parsed to a negative integer',
        () async {
      const input = '-1';

      final result = inputConverter.unsignedIntFromString(input);

      expect(result, Left(InvalidInputFailure()));
    });
  });
}
