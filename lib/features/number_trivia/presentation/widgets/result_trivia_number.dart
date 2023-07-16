import 'package:flutter/material.dart';

class ResultTriviaNumber extends StatelessWidget {
  final int numberTrivia;
  const ResultTriviaNumber({super.key, required this.numberTrivia});

  @override
  Widget build(BuildContext context) {
    return Text(
      numberTrivia.toString(),
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
