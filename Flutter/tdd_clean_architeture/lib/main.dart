import 'package:flutter/material.dart';
import 'package:study_flutter_clean_architeture/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'injection_container.dart' as injection_container;

void main() async {
  await injection_container.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      theme: ThemeData(primaryColor: Colors.green.shade800),
      home: const NumberTriviaPage(),
    );
  }
}
