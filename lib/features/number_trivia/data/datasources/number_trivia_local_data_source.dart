import '../../domain/entities/number_trivia.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTrivia> getLastNumberTrivia(int number);
  Future<void> cacheNumberTrivia(NumberTrivia numberTrivia);
}
