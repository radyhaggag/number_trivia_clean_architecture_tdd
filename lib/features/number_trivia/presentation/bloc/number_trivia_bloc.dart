import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/utils/input_converter.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) : super(NumberTriviaInitial()) {
    on<GetTriviaForConcreteNumber>(_getTriviaForConcreteNumber);
    on<GetTriviaForRandomNumber>(_getTriviaForRandomNumber);
  }

  Future<void> _getTriviaForConcreteNumber(
    GetTriviaForConcreteNumber event,
    Emitter<NumberTriviaState> emit,
  ) async {
    emit(NumberTriviaLoading());
    final result = inputConverter.stringToUnsignedInteger(event.stringNumber);
    await result.fold(
      (l) {
        emit(NumberTriviaLoadingError(l.message));
      },
      (r) async {
        final params = ConcreteNumberParams(r);
        final result = await getConcreteNumberTrivia(params);
        result.fold(
          (l) => emit(NumberTriviaLoadingError(l.message)),
          (r) => emit(NumberTriviaLoadingSuccess(r)),
        );
      },
    );
  }

  Future<void> _getTriviaForRandomNumber(
    GetTriviaForRandomNumber event,
    Emitter<NumberTriviaState> emit,
  ) async {
    emit(NumberTriviaLoading());
    final result = await getRandomNumberTrivia(null);
    result.fold(
      (l) => emit(NumberTriviaLoadingError(l.message)),
      (r) => emit(NumberTriviaLoadingSuccess(r)),
    );
  }
}
