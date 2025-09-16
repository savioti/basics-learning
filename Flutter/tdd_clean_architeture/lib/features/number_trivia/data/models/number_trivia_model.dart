import 'package:study_flutter_clean_architeture/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({
    required int number,
    required String text,
  }) : super(
          number: number,
          text: text,
        );

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    final number = json['number'] as num;

    return NumberTriviaModel(
      number: number.toInt(),
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "number": number,
      "text": text,
    };
  }
}
