import 'package:flutter/material.dart';

class StartSearchMsg extends StatelessWidget {
  const StartSearchMsg({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Let's start search about trivia.",
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
