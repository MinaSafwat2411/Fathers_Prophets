import 'package:injectable/injectable.dart';

import '../../../data/models/quizzes_score/quizzes_score_model.dart';
import '../../../data/repositories/quizzes_score/i_quizzes_score_repository.dart';
import 'i_quizzes_score_use_case.dart';

@LazySingleton(as: IQuizzesScoreUseCase)
class QuizzesScoreUseCase implements IQuizzesScoreUseCase{

  final IQuizzesScoreRepository quizzesScoreRepository;

  QuizzesScoreUseCase(this.quizzesScoreRepository);

  @override
  Future<List<QuizzesScoreModel>> getQuizzesScore() async {
    return await quizzesScoreRepository.getQuizzesScore();
  }

  @override
  Future<QuizzesScoreModel?> getQuizzesScoreById(String id) async {
    return await quizzesScoreRepository.getQuizzesScoreById(id);
  }

  @override
  Future<void> addQuizzesScore(String uid,QuizzesScoreModel quizzesScoreModel)async {
    await quizzesScoreRepository.addNewQuizzesScore(uid,quizzesScoreModel);
  }

  @override
  Future<void> updateQuizzesScore(String id,QuizzesScoreModel quizzesScoreModel)async {
    await quizzesScoreRepository.updateQuizzesScore(id ,quizzesScoreModel);
  }
}