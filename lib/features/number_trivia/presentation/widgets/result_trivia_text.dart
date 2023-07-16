import 'package:flutter/material.dart';

class ResultTriviaMsg extends StatelessWidget {
  final String message;
  const ResultTriviaMsg({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
