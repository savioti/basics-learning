import 'package:study_flutter_clean_architeture/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel?> getLastNumberTrivia();

  Future<void> cacheNumber(NumberTriviaModel triviaModelToBeCached);
}
