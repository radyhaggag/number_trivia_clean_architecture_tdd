import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';

import '../../../../core/api/api_consumer.dart';

import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final ApiConsumer apiConsumer;

  NumberTriviaRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    return await _getTrivia('$number');
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    return await _getTrivia('random');
  }

  Future<NumberTriviaModel> _getTrivia(String endpoint) async {
    final result = await apiConsumer.get(endpoint: endpoint) as Response;
    if (result.statusCode == 200) {
      final numberTrivia = NumberTriviaModel.fromJson(result.data);
      return numberTrivia;
    } else {
      throw ServerException();
    }
  }
}
