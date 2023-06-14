import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_clean_architecture_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia_clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture.dart';

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

  group('Number trivia model from json', () {
    test(
      'Should return a valid model when the json number is an integer',
      () {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('trivia.json'));
        // act
        final NumberTriviaModel result = NumberTriviaModel.fromJson(jsonMap);
        // assert
        expect(result, tNumberTriviaModel);
      },
    );
    test(
      'Should return a valid model when the json number is an double',
      () {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('trivia_double.json'));
        // act
        final NumberTriviaModel result = NumberTriviaModel.fromJson(jsonMap);
        // assert
        expect(result, tNumberTriviaModel);
      },
    );
  });

  group('Number trivia model to json', () {
    test('Should return a json map with the same data', () {
      // arrange
      // act
      final Map<String, dynamic> result = tNumberTriviaModel.toJson();
      // assert
      final expectedMap = {
        "text": "test",
        "number": 42,
      };
      expect(result, expectedMap);
    });
  });
}
