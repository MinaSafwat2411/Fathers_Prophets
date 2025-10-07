import 'package:fathers_prophets/data/models/classes/class_model.dart';
import 'package:fathers_prophets/data/models/classes/class_user_model.dart';
import 'package:fathers_prophets/data/models/quizzes/quizzes_model.dart';
import 'package:fathers_prophets/data/models/quizzes_score/quizzes_score_model.dart';
import 'package:fathers_prophets/data/services/cache/cache_helper.dart';
import 'package:fathers_prophets/data/services/cache/i_cache_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repositories/quizzes_score/quizzes_score_repository.dart';
import '../../../../domain/usecases/quizzes_score/i_quizzes_score_use_case.dart';
import '../../../../domain/usecases/quizzes_score/quizzes_score_use_case.dart';
import '../states/quiz_table_states.dart';

class QuizTableCubit extends Cubit<QuizTableStates> {
  QuizTableCubit(this.quizzesScoreUseCase,this.cacheHelper) : super(OnLoading());

  static QuizTableCubit get(context) => BlocProvider.of(context);

  List<QuizzesScoreModel> quizzesScore = <QuizzesScoreModel>[];
  List<QuizzesModel> quizzes = <QuizzesModel>[];
  List<ClassModel> classes = <ClassModel>[];
  var selectedMember = ClassUserModel();
  var selectedQuiz = QuizzesModel();
  ClassModel selectedClass = ClassModel();
  TextEditingController nameController = TextEditingController();
  TextEditingController quizNumberController = TextEditingController();
  TextEditingController scoreController = TextEditingController();

  final IQuizzesScoreUseCase quizzesScoreUseCase;
  final ICacheHelper cacheHelper;

  void getAllQuizzesScore() async {
    emit(OnLoading());
    try {
      quizzes = cacheHelper.getQuizzes();
      classes = cacheHelper.getClasses();
      quizzesScore = await quizzesScoreUseCase.getQuizzesScore();
      emit(OnSuccess());
    } catch (e) {
      emit(OnError(e.toString()));
    }
  }

  void addQuizzesScore() async {
    emit(OnLoading());
    try {
      final newScore = QuizzesScoreModel(
        name: selectedMember.name,
        score: int.parse(scoreController.text),
        quizzes: [selectedQuiz.docId ?? ""],
      );

      await quizzesScoreUseCase.updateQuizzesScore(
        selectedMember.uid ?? "",
        newScore,
      );
      if (quizzesScore.any((element) => element.name == selectedMember.name)) {
        quizzesScore[quizzesScore.indexWhere((element) => element.name == selectedMember.name)] = newScore;
      } else {
        quizzesScore.add(newScore);
      }
      emit(OnSuccess());
    } catch (e) {
      emit(OnError(e.toString()));
    }
  }

  void onSelectMember(ClassUserModel member) {
    selectedMember = member;
    emit(OnSelectMember());
  }

  void onSelectQuiz(QuizzesModel quiz) {
    selectedQuiz = quiz;
    emit(OnSelectQuiz());
  }
  
  void onClassSelected(ClassModel item) {
    selectedClass = item;
    emit(OnSelectClass());
  }

  void onSearchScore() {
    quizzesScore.where((element) => element.score.toString().contains(scoreController.text)).toList();
    emit(OnSearch());
  }
}
