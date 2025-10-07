import 'package:fathers_prophets/data/repositories/quizzes_score/quizzes_score_repository.dart';

import '../../../data/models/quizzes_score/quizzes_score_model.dart';

abstract class IQuizzesScoreUseCase {


  Future<List<QuizzesScoreModel>> getQuizzesScore();

  Future<QuizzesScoreModel?> getQuizzesScoreById(String id);

  Future<void> addQuizzesScore(String uid,QuizzesScoreModel quizzesScoreModel);

  Future<void> updateQuizzesScore(String id,QuizzesScoreModel quizzesScoreModel);
}