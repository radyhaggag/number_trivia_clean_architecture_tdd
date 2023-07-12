import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../models/number_trivia_model.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/number_trivia_local_data_source.dart';
import '../datasources/number_trivia_remote_data_source.dart';
import '../../domain/entities/number_trivia.dart';

import '../../domain/repositories/number_trivia_repository.dart';

typedef _ConcreteOrRandomChooser = Future<NumberTrivia> Function();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource numberTriviaRemoteDataSource;
  final NumberTriviaLocalDataSource numberTriviaLocalDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.numberTriviaRemoteDataSource,
    required this.numberTriviaLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
    int number,
  ) async {
    return await _getTrivia(
      () => numberTriviaRemoteDataSource.getConcreteNumberTrivia(number),
    );
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(
      () => numberTriviaRemoteDataSource.getRandomNumberTrivia(),
    );
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
    _ConcreteOrRandomChooser concreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await concreteOrRandom();
        await numberTriviaLocalDataSource.cacheNumberTrivia(
          result as NumberTriviaModel,
        );
        return Right(result);
      } on ServerException {
        return const Left(ServerFailure(''));
      }
    } else {
      try {
        final result = await numberTriviaLocalDataSource.getLastNumberTrivia();
        return Right(result);
      } on CacheException {
        return const Left(CacheFailure('no data'));
      }
    }
  }
}
