import 'package:fathers_prophets/data/repositories/quizzes/quizzes_repository.dart';

import '../../../data/models/quizzes/quizzes_model.dart';

class QuizzesUseCase {
  final QuizzesRepository quizzesRepository;

  QuizzesUseCase(this.quizzesRepository);

  Future<List<QuizzesModel?>?> getAllQuizzes() async {
    return await quizzesRepository.getAllQuizzes();
  }

  Future<String?> addNewQuiz(QuizzesModel quizzesModel)async{
    return await quizzesRepository.addNewQuiz(quizzesModel);
  }
  Future<void> updateQuiz(QuizzesModel quizzesModel)async{
    await quizzesRepository.updateQuiz(quizzesModel);
  }
  Future<void> deleteQuiz(String id)async {
    await quizzesRepository.deleteQuiz(id);
  }
  Future<QuizzesModel?> getQuizById(String id)async{
    return await quizzesRepository.getQuizById(id);
  }

}