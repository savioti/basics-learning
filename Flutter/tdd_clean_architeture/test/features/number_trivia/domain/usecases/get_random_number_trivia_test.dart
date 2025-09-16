import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

import 'get_concrete_number_trivia_test.mocks.dart';

@GenerateMocks([NumberTriviaRepository])
void main() {
  final mockNumberTriviaRepository = MockNumberTriviaRepository();
  const tNumberTrivia = NumberTrivia(number: 1, text: 'test');
  final useCase = GetRandomNumberTrivia(mockNumberTriviaRepository);

  test(
    'should get a random trivia from the repository',
    () async {
      //arrange
      when(mockNumberTriviaRepository.getRandomNumberTrivia())
          .thenAnswer((_) async => const Right(tNumberTrivia));
      // act
      final result = await useCase(NoParams());
      // assert
      expect(result, const Right(tNumberTrivia));
      verify(mockNumberTriviaRepository.getRandomNumberTrivia());
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
