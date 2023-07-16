import 'package:flutter/material.dart';

import '../widgets/number_trivia_screen_body.dart';

class NumberTriviaScreen extends StatelessWidget {
  const NumberTriviaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number trivia'),
      ),
      body: const NumberTriviaScreenBody(),
    );
  }
}
