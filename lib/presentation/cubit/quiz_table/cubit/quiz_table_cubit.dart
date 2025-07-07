import 'package:fathers_prophets/data/models/quizzes/quizzes_model.dart';
import 'package:fathers_prophets/data/models/quizzes_score/quizzes_score_model.dart';
import 'package:fathers_prophets/data/models/users/users_model.dart';
import 'package:fathers_prophets/data/services/cache_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repositories/quizzes_score/quizzes_score_repository.dart';
import '../../../../domain/usecases/quizzes_score/quizzes_score_use_case.dart';
import '../states/quiz_table_states.dart';

class QuizTableCubit extends Cubit<QuizTableStates> {
  QuizTableCubit() : super(OnLoading());

  static QuizTableCubit get(context) => BlocProvider.of(context);

  List<QuizzesScoreModel> quizzesScore = <QuizzesScoreModel>[];
  List<UserModel> members = <UserModel>[];
  List<QuizzesModel> quizzes = <QuizzesModel>[];
  var selectedMember = UserModel();
  var selectedQuiz = QuizzesModel();
  var selectedClass = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController quizNumberController = TextEditingController();
  TextEditingController scoreController = TextEditingController();

  final QuizzesScoreUseCase quizzesScoreUseCase = QuizzesScoreUseCase(
    QuizzesScoreRepository(),
  );

  void getAllQuizzesScore() async {
    emit(OnLoading());
    try {
      quizzes = CacheHelper.getQuizzes();
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

  void onSelectMember(UserModel member) {
    selectedMember = member;
    emit(OnSelectMember());
  }

  void onSelectQuiz(QuizzesModel quiz) {
    selectedQuiz = quiz;
    emit(OnSelectQuiz());
  }
  
  void onClassSelected(String classId) {
    selectedClass = classId;
    members = CacheHelper.getMembersByClassId(classId);
    emit(OnSelectClass());
  }

  void onSearchName() {
    members.where((element) => element.name!.contains(nameController.text)).toList();
    emit(OnSearch());
  }

  void onSearchScore() {
    quizzesScore.where((element) => element.score.toString().contains(scoreController.text)).toList();
    emit(OnSearch());
  }
}
