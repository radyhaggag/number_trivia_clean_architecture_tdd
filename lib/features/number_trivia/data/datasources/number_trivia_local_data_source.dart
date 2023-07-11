import 'dart:convert';

import 'package:number_trivia_clean_architecture_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/number_trivia.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTrivia> getLastNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTrivia numberTrivia);
}

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<NumberTrivia> getLastNumberTrivia() async {
    final result = sharedPreferences.getString('CACHED_NUMBER_TRIVIA');
    final numberTrivia = NumberTriviaModel.fromJson(json.decode(result!));
    return Future.value(numberTrivia);
  }

  @override
  Future<void> cacheNumberTrivia(NumberTrivia numberTrivia) async {
    // TODO: implement cacheNumberTrivia
    throw UnimplementedError();
  }
}
