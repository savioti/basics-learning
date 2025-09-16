import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:study_flutter_clean_architeture/core/error/failures/cache_failure.dart';
import 'package:study_flutter_clean_architeture/core/error/failures/invalid_input_failure.dart';
import 'package:study_flutter_clean_architeture/core/error/failures/server_failure.dart';
import 'package:study_flutter_clean_architeture/core/util/input_converter.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

import 'number_trivia_bloc_test.mocks.dart';

@GenerateMocks([GetConcreteNumberTrivia, GetRandomNumberTrivia, InputConverter])
void main() {
  late final MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late final MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late final MockInputConverter mockInputConverter;
  late final NumberTriviaBloc bloc;
  const tNumberTrivia = NumberTrivia(text: 'test trivia', number: 1);

  setUpAll(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
      getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
      getRandomNumberTrivia: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  test('initialState should be empty', () {
    expect(bloc.state, equals(NumberTriviaEmptyState()));
  });

  group('getTriviaForConcreteNumber', () {
    const tNumberString = '1';
    const tParsedNumber = 1;

    void _setUpMockInputConverterSuccess() =>
        when(mockInputConverter.unsignedIntFromString(any))
            .thenReturn(const Right(tParsedNumber));

    test(
        'should call the InputConverter to validate and convert the string to an unsigned integer',
        () async {
      _setUpMockInputConverterSuccess();

      bloc.add(const ConcreteNumberTriviaEvent(
        triviaNumber: tNumberString,
      ));

      await untilCalled(mockInputConverter.unsignedIntFromString(any));
      verify(mockInputConverter.unsignedIntFromString(tNumberString));
    });

    test('should emit Error state when the input is invalid', () async {
      when(mockInputConverter.unsignedIntFromString(any))
          .thenReturn(Left(InvalidInputFailure()));

      await untilCalled(mockInputConverter.unsignedIntFromString(any));
      expectLater(
        bloc.stream.asBroadcastStream(),
        emits(const NumberTriviaErrorState(
            error: NumberTriviaBloc.invalidInputFailureMessage)),
      );

      bloc.add(const ConcreteNumberTriviaEvent(
        triviaNumber: tNumberString,
      ));
    });

    test('should get data from the concrete use case', () async {
      _setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => const Right(tNumberTrivia));

      bloc.add(const ConcreteNumberTriviaEvent(triviaNumber: tNumberString));
      await untilCalled(mockInputConverter.unsignedIntFromString(any));

      verify(mockGetConcreteNumberTrivia(const Params(number: tParsedNumber)));
    });

    test('should emit [NumberTriviaLoadingState, NumberTriviaDoneState]',
        () async {
      _setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => const Right(tNumberTrivia));

      final expectedStates = [
        NumberTriviaLoadingState(),
        const NumberTriviaDoneState(trivia: tNumberTrivia),
      ];

      expectLater(
        bloc.stream.asBroadcastStream(),
        emitsInOrder(expectedStates),
      );
      bloc.add(const ConcreteNumberTriviaEvent(triviaNumber: tNumberString));
    });

    test('should emit [NumberTriviaLoadingState, NumberTriviaErrorState]',
        () async {
      _setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      final expectedStates = [
        NumberTriviaLoadingState(),
        const NumberTriviaErrorState(
          error: NumberTriviaBloc.serverFailureMessage,
        ),
      ];

      expectLater(
        bloc.stream.asBroadcastStream(),
        emitsInOrder(expectedStates),
      );
      bloc.add(const ConcreteNumberTriviaEvent(triviaNumber: tNumberString));
    });

    test(
        'should emit [NumberTriviaLoadingState, NumberTriviaErrorState] with a proper error when data retrieving fails',
        () async {
      _setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      final expectedStates = [
        NumberTriviaLoadingState(),
        const NumberTriviaErrorState(
          error: NumberTriviaBloc.cacheFailureMessage,
        ),
      ];

      expectLater(
        bloc.stream.asBroadcastStream(),
        emitsInOrder(expectedStates),
      );
      bloc.add(const ConcreteNumberTriviaEvent(triviaNumber: tNumberString));
    });
  });

  group('getTriviaForRandomNumber', () {
    test('should get data from the random use case', () async {
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => const Right(tNumberTrivia));

      bloc.add(RandomNumberTriviaEvent());
      await untilCalled(mockGetRandomNumberTrivia(any));
      verify(mockGetRandomNumberTrivia(NoParams()));
    });

    test('should emit [NumberTriviaLoadingState, NumberTriviaDoneState]',
        () async {
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => const Right(tNumberTrivia));

      final expectedStates = [
        NumberTriviaLoadingState(),
        const NumberTriviaDoneState(trivia: tNumberTrivia),
      ];

      expectLater(
        bloc.stream.asBroadcastStream(),
        emitsInOrder(expectedStates),
      );
      bloc.add(RandomNumberTriviaEvent());
    });

    test('should emit [NumberTriviaLoadingState, NumberTriviaErrorState]',
        () async {
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      final expectedStates = [
        NumberTriviaLoadingState(),
        const NumberTriviaErrorState(
          error: NumberTriviaBloc.serverFailureMessage,
        ),
      ];

      expectLater(
        bloc.stream.asBroadcastStream(),
        emitsInOrder(expectedStates),
      );
      bloc.add(RandomNumberTriviaEvent());
    });

    test(
        'should emit [NumberTriviaLoadingState, NumberTriviaErrorState] with a proper error when data retrieving fails',
        () async {
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      final expectedStates = [
        NumberTriviaLoadingState(),
        const NumberTriviaErrorState(
          error: NumberTriviaBloc.cacheFailureMessage,
        ),
      ];

      expectLater(
        bloc.stream.asBroadcastStream(),
        emitsInOrder(expectedStates),
      );
      bloc.add(RandomNumberTriviaEvent());
    });
  });
}
