import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:study_flutter_clean_architeture/core/error/failures/cache_failure.dart';
import 'package:study_flutter_clean_architeture/core/error/failures/failure.dart';
import 'package:study_flutter_clean_architeture/core/error/failures/server_failure.dart';
import 'package:study_flutter_clean_architeture/core/util/input_converter.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  static const String serverFailureMessage = 'Server failure';
  static const String cacheFailureMessage = 'Cache failure';
  static const String invalidInputFailureMessage =
      'Invalid input: the number must be a positive integer or zero.';
  static const String genericFailure = 'Unexpected error..';

  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) : super(NumberTriviaEmptyState()) {
    on<ConcreteNumberTriviaEvent>(_onConcreteNumberTriviaEvent);
    on<RandomNumberTriviaEvent>(_onRandomNumberTriviaEvent);
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return serverFailureMessage;
    } else if (failure is CacheFailure) {
      return cacheFailureMessage;
    } else {
      return genericFailure;
    }
  }

  void _onConcreteNumberTriviaEvent(
      ConcreteNumberTriviaEvent event, Emitter<NumberTriviaState> emit) async {
    final convertedInput =
        inputConverter.unsignedIntFromString(event.triviaNumber);

    await convertedInput.fold(
      (_) async =>
          emit(const NumberTriviaErrorState(error: invalidInputFailureMessage)),
      (number) async {
        emit(NumberTriviaLoadingState());
        final failureOrTrivia =
            await getConcreteNumberTrivia(Params(number: number));

        if (isClosed) {
          return;
        }

        if (!emit.isDone) {
          failureOrTrivia.fold(
            (failure) {
              final failureMessage = _mapFailureToMessage(failure);
              emit(NumberTriviaErrorState(error: failureMessage));
            },
            (trivia) => emit(NumberTriviaDoneState(trivia: trivia)),
          );
        }
      },
    );
  }

  void _onRandomNumberTriviaEvent(
    RandomNumberTriviaEvent event,
    Emitter<NumberTriviaState> emit,
  ) async {
    emit(NumberTriviaLoadingState());
    final failureOrTrivia = await getRandomNumberTrivia(NoParams());

    if (isClosed) {
      return;
    }

    failureOrTrivia.fold(
      (failure) {
        final failureMessage = _mapFailureToMessage(failure);
        emit(NumberTriviaErrorState(error: failureMessage));
      },
      (trivia) => emit(NumberTriviaDoneState(trivia: trivia)),
    );
  }
}
