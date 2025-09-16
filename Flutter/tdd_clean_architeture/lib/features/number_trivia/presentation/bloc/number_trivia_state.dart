part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];
}

class NumberTriviaEmptyState extends NumberTriviaState {}

class NumberTriviaLoadingState extends NumberTriviaState {}

class NumberTriviaDoneState extends NumberTriviaState {
  final NumberTrivia trivia;

  const NumberTriviaDoneState({required this.trivia});

  @override
  List<Object> get props => [trivia];
}

class NumberTriviaErrorState extends NumberTriviaState {
  final String error;

  const NumberTriviaErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
