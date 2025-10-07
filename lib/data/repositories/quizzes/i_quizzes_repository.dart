import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../models/quizzes/quizzes_model.dart';

abstract class IQuizzesRepository {
  Future<List<QuizzesModel?>?> getAllQuizzes();
  Future<String?> addNewQuiz(QuizzesModel quizzesModel);
  Future<void> updateQuiz(QuizzesModel quizzesModel);
  Future<void> deleteQuiz(String id);
  Future<QuizzesModel?> getQuizById(String id);
}