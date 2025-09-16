import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class TriviaButtons extends StatefulWidget {
  const TriviaButtons({
    Key? key,
  }) : super(key: key);

  @override
  State<TriviaButtons> createState() => _TriviaButtonsState();
}

class _TriviaButtonsState extends State<TriviaButtons> {
  String input = '';

  void _callConcreteTriviaCall() {
    final bloc = BlocProvider.of<NumberTriviaBloc>(context);
    bloc.add(ConcreteNumberTriviaEvent(triviaNumber: input));
  }

  void _callRandomTriviaCall() {
    final bloc = BlocProvider.of<NumberTriviaBloc>(context);
    bloc.add(RandomNumberTriviaEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Type a number',
          ),
          onChanged: (value) {
            input = value;
          },
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                child: const Text('Search'),
                onPressed: _callConcreteTriviaCall,
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: ElevatedButton(
                child: const Text('Random number'),
                onPressed: _callRandomTriviaCall,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
