part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final String stringNumber;

  const GetTriviaForConcreteNumber(this.stringNumber);

  @override
  List<Object> get props => [stringNumber];
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {}
