import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/number_trivia_bloc.dart';

class EnterNumberTriviaFormField extends StatelessWidget {
  final TextEditingController controller;
  const EnterNumberTriviaFormField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      onFieldSubmitted: (value) {
        context.read<NumberTriviaBloc>().add(
              GetTriviaForConcreteNumber(value),
            );
        controller.clear();
      },
      decoration: const InputDecoration(
        hintText: 'Enter number for get trivia...',
      ),
    );
  }
}
