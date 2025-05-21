import 'package:fathers_prophets/data/models/quizzes/questions_model.dart';

class QuizModel {
  final List<QuestionsModel>? questions;
  String? shahid;

  QuizModel({this.questions, this.shahid});

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => QuestionsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      shahid: json['shahid']??"",
    );
  }

  Map<String, dynamic> toJson() => {
    'questions': questions?.map((e) => e.toJson()).toList(),
    'shahid': shahid,
  };
}
