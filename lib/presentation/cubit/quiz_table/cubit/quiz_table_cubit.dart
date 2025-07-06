
import 'package:fathers_prophets/data/models/quizzes_score/quizzes_score_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repositories/quizzes_score/quizzes_score_repository.dart';
import '../../../../domain/usecases/quizzes_score/quizzes_score_use_case.dart';
import '../states/quiz_table_states.dart';

class QuizTableCubit extends Cubit<QuizTableStates>{
  QuizTableCubit() : super(OnLoading());
  static QuizTableCubit get(context) => BlocProvider.of(context);


  List<QuizzesScoreModel> quizzesScore = <QuizzesScoreModel>[];
  final QuizzesScoreUseCase quizzesScoreUseCase = QuizzesScoreUseCase(QuizzesScoreRepository());


  void getAllQuizzesScore()async{
    emit(OnLoading());
    try{
      quizzesScore = await quizzesScoreUseCase.getQuizzesScore();
      emit(OnSuccess());
    }catch(e){
      emit(OnError(e.toString()));
    }
  }
}