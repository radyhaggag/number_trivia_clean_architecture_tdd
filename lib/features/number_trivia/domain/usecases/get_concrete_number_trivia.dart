import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia
    implements UseCase<NumberTrivia, ConcreteNumberParams> {
  final NumberTriviaRepository numberTriviaRepository;

  GetConcreteNumberTrivia(this.numberTriviaRepository);

  @override
  Future<Either<Failure, NumberTrivia>> call(
    ConcreteNumberParams params,
  ) async {
    return await numberTriviaRepository.getConcreteNumberTrivia(params.number);
  }
}

class ConcreteNumberParams extends Equatable {
  final int number;

  const ConcreteNumberParams(this.number);

  @override
  List<Object?> get props => [number];
}
