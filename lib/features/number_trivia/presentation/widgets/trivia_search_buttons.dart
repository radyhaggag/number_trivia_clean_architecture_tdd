import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/number_trivia_bloc.dart';

class TriviaSearchButtons extends StatelessWidget {
  final TextEditingController controller;
  const TriviaSearchButtons({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              context.read<NumberTriviaBloc>().add(
                    GetTriviaForConcreteNumber(controller.text),
                  );
              controller.clear();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Search'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              context.read<NumberTriviaBloc>().add(
                    GetTriviaForRandomNumber(),
                  );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white54,
            ),
            child: const Text('Get random'),
          ),
        ),
      ],
    );
  }
}
