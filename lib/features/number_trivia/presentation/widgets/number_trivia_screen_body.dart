import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../bloc/number_trivia_bloc.dart';
import 'enter_number_form_field.dart';
import 'number_trivia_head.dart';
import 'trivia_search_buttons.dart';

class NumberTriviaScreenBody extends StatefulWidget {
  const NumberTriviaScreenBody({super.key});

  @override
  State<NumberTriviaScreenBody> createState() => _NumberTriviaScreenBodyState();
}

class _NumberTriviaScreenBodyState extends State<NumberTriviaScreenBody> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NumberTriviaBloc>(
      create: (context) => sl<NumberTriviaBloc>(),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              const NumberTriviaHead(),
              const SizedBox(height: 25),
              EnterNumberTriviaFormField(controller: controller),
              const SizedBox(height: 25),
              TriviaSearchButtons(controller: controller),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
