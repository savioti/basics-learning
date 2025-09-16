part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class ConcreteNumberTriviaEvent extends NumberTriviaEvent {
  final String triviaNumber;

  const ConcreteNumberTriviaEvent({required this.triviaNumber});

  @override
  List<Object> get props => [triviaNumber];
}

class RandomNumberTriviaEvent extends NumberTriviaEvent {}
