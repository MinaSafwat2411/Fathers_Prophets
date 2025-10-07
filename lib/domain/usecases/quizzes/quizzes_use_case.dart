import 'package:fathers_prophets/data/repositories/quizzes/quizzes_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/quizzes/quizzes_model.dart';
import '../../../data/repositories/quizzes/i_quizzes_repository.dart';
import 'i_quizzes_use_case.dart';

@LazySingleton(as: IQuizzesUseCase)
class QuizzesUseCase implements IQuizzesUseCase{
  final IQuizzesRepository quizzesRepository;

  QuizzesUseCase(this.quizzesRepository);

  @override
  Future<List<QuizzesModel?>?> getAllQuizzes() async {
    return await quizzesRepository.getAllQuizzes();
  }

  @override
  Future<String?> addNewQuiz(QuizzesModel quizzesModel)async{
    return await quizzesRepository.addNewQuiz(quizzesModel);
  }
  @override
  Future<void> updateQuiz(QuizzesModel quizzesModel)async{
    await quizzesRepository.updateQuiz(quizzesModel);
  }
  @override
  Future<void> deleteQuiz(String id)async {
    await quizzesRepository.deleteQuiz(id);
  }
  @override
  Future<QuizzesModel?> getQuizById(String id)async{
    return await quizzesRepository.getQuizById(id);
  }

}