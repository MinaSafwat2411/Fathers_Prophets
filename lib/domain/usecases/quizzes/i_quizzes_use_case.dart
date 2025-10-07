import 'package:fathers_prophets/data/repositories/quizzes/quizzes_repository.dart';

import '../../../data/models/quizzes/quizzes_model.dart';

abstract class IQuizzesUseCase {

  Future<List<QuizzesModel?>?> getAllQuizzes();

  Future<String?> addNewQuiz(QuizzesModel quizzesModel);
  Future<void> updateQuiz(QuizzesModel quizzesModel);
  Future<void> deleteQuiz(String id);
  Future<QuizzesModel?> getQuizById(String id);

}