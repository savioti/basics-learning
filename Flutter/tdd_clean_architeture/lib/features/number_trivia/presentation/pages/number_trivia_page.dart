import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/presentation/widgets/loading_indicator.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/presentation/widgets/message_display.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/presentation/widgets/trivia_buttons.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/presentation/widgets/trivia_display.dart';
import 'package:study_flutter_clean_architeture/injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
      ),
      body: BlocProvider(
        create: (_) => serviceLocator<NumberTriviaBloc>(),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  // Top half
                  const SizedBox(height: 10.0),
                  BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                    builder: (context, state) {
                      if (state is NumberTriviaLoadingState) {
                        return const LoadingIndicator();
                      }

                      if (state is NumberTriviaEmptyState) {
                        return const MessageDisplay(
                          message: 'Start searching...',
                        );
                      }

                      if (state is NumberTriviaErrorState) {
                        return MessageDisplay(message: state.error);
                      }

                      if (state is NumberTriviaDoneState) {
                        return TriviaDisplay(numberTrivia: state.trivia);
                      }

                      return const SizedBox();
                    },
                  ),
                  const SizedBox(height: 20.0),
                  // Bottom half
                  const TriviaButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
