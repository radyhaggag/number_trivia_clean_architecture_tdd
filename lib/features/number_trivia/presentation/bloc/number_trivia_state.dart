part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];
}

class NumberTriviaInitial extends NumberTriviaState {}

class NumberTriviaLoading extends NumberTriviaState {}

class NumberTriviaLoadingSuccess extends NumberTriviaState {
  final NumberTrivia numberTrivia;

  const NumberTriviaLoadingSuccess(this.numberTrivia);

  @override
  List<Object> get props => [numberTrivia];
}

class NumberTriviaLoadingError extends NumberTriviaState {
  final String message;

  const NumberTriviaLoadingError(this.message);

  @override
  List<Object> get props => [message];
}
