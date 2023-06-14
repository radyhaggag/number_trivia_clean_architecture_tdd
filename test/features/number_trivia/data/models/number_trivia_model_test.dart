import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_clean_architecture_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia_clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';

void main() {
  late NumberTriviaModel tNumberTriviaModel;

  setUp(() {
    tNumberTriviaModel = const NumberTriviaModel(text: "test", number: 42);
  });

  test('Should be a subclass of NumberTrivia Entity', () {
    // arrange
    // act
    // assert
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });
}
