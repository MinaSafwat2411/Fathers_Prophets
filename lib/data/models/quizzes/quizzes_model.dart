
import 'package:fathers_prophets/data/models/quizzes/quiz_model.dart';

class QuizzesModel {
  final int? number;
  final QuizModel? friday;
  final QuizModel? monday;
  final QuizModel? saturday;
  final QuizModel? sunday;
  final QuizModel? thursday;
  final QuizModel? tuesday;
  final QuizModel? wednesday;
  final String? docId;

  QuizzesModel({
    this.number,
    this.friday,
    this.monday,
    this.saturday,
    this.sunday,
    this.thursday,
    this.tuesday,
    this.wednesday,
    this.docId,
  });

  factory QuizzesModel.fromJson(Map<String, dynamic> json,String docId) {
    return QuizzesModel(
      number: json['number']??-1,
      friday: (json['friday'] as Map<String, dynamic>?) != null ? QuizModel.fromJson(json['friday']as Map<String, dynamic>) : null,
      monday: (json['monday'] as Map<String, dynamic>?) != null ? QuizModel.fromJson(json['monday']as Map<String, dynamic>) : null,
      saturday: (json['saturday'] as Map<String, dynamic>?) != null ? QuizModel.fromJson(json['saturday']as Map<String, dynamic>) : null,
      sunday: (json['sunday'] as Map<String, dynamic>?) != null ? QuizModel.fromJson(json['sunday']as Map<String, dynamic>) : null,
      thursday: (json['thursday'] as Map<String, dynamic>?) != null ? QuizModel.fromJson(json['thursday']as Map<String, dynamic>) : null,
      tuesday: (json['tuesday'] as Map<String, dynamic>?) != null ? QuizModel.fromJson(json['tuesday']as Map<String, dynamic>) : null,
      wednesday: (json['wednesday'] as Map<String, dynamic>?) != null ? QuizModel.fromJson(json['wednesday']as Map<String, dynamic>) : null,
      docId: docId,
    );
  }

  Map<String, dynamic> toJson() => {
    'number': number,
    'friday': friday?.toJson(),
    'monday': monday?.toJson(),
    'saturday': saturday?.toJson(),
    'sunday': sunday?.toJson(),
    'thursday': thursday?.toJson(),
    'tuesday': tuesday?.toJson(),
    'wednesday': wednesday?.toJson(),
    'docId': docId,
  };
}