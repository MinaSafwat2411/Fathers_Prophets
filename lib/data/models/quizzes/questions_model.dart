
class QuestionsModel {
  final List<String?>? answers;
  final String? question;
  int? correctAnswer;

  QuestionsModel({
    this.answers,
    this.question,
    this.correctAnswer,
});

  factory QuestionsModel.fromJson(Map<String, dynamic> json) {
    return QuestionsModel(
        question: json['question']??"",
        correctAnswer: json['correctAnswer']??-1,
        answers: (json['answers'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'answers': answers,
    'question': question,
    'correctAnswer': correctAnswer,
  };

}