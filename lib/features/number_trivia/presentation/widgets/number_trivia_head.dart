import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/number_trivia_bloc.dart';
import 'error_message_widget.dart';
import 'result_trivia_number.dart';
import 'result_trivia_text.dart';
import 'start_search_msg.dart';

class NumberTriviaHead extends StatelessWidget {
  const NumberTriviaHead({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.sizeOf(context).height / 3,
      child: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
        builder: (context, state) {
          if (state is NumberTriviaLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NumberTriviaLoadingSuccess) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ResultTriviaNumber(numberTrivia: state.numberTrivia.number),
                  const SizedBox(height: 15),
                  ResultTriviaMsg(message: state.numberTrivia.text),
                ],
              ),
            );
          } else if (state is NumberTriviaLoadingError) {
            return ErrorMessageWidget(message: state.message);
          } else {
            return const StartSearchMsg();
          }
        },
      ),
    );
  }
}
