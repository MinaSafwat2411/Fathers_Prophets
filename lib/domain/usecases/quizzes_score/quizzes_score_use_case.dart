import 'package:fathers_prophets/data/repositories/quizzes_score/quizzes_score_repository.dart';

import '../../../data/models/quizzes_score/quizzes_score_model.dart';

class QuizzesScoreUseCase {

  final QuizzesScoreRepository quizzesScoreRepository;

  QuizzesScoreUseCase(this.quizzesScoreRepository);

  Future<List<QuizzesScoreModel>> getQuizzesScore() async {
    return await quizzesScoreRepository.getQuizzesScore();
  }

  Future<QuizzesScoreModel?> getQuizzesScoreById(String id) async {
    return await quizzesScoreRepository.getQuizzesScoreById(id);
  }

  Future<void> addQuizzesScore(String uid,QuizzesScoreModel quizzesScoreModel)async {
    await quizzesScoreRepository.addNewQuizzesScore(uid,quizzesScoreModel);
  }

  Future<void> updateQuizzesScore(String id,QuizzesScoreModel quizzesScoreModel)async {
    await quizzesScoreRepository.updateQuizzesScore(id ,quizzesScoreModel);
  }
}