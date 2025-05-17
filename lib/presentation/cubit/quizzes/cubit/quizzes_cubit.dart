import 'package:fathers_prophets/data/models/quizzes/quizzes_model.dart';
import 'package:fathers_prophets/data/models/users/users_model.dart';
import 'package:fathers_prophets/data/services/cache_helper.dart';
import 'package:fathers_prophets/presentation/cubit/quizzes/states/quizzes_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/firebase_endpoints.dart';
import '../../../../data/models/quizzes/quiz_answers.dart';
import '../../../../data/models/users/member_quizzes_model.dart';
import '../../../../data/repositories/users/users_repository.dart';
import '../../../../domain/usecases/users/users_use_case.dart';

class QuizzesCubit extends Cubit<QuizzesStates>{
  QuizzesCubit() : super(InitialState());

  static QuizzesCubit get(context) => BlocProvider.of(context);

  var userData =  UserModel();
  var quizAnswers = QuizAnswers();
  var quiz = QuizzesModel();
  final UsersUseCase usersUseCase = UsersUseCase(UserRepository());
  var score = 0;
  void createQuizAnswers(String docId,QuizzesModel quiz){
    score = 0;
    userData = CacheHelper.getUserData();
    this.quiz = quiz;
    var cache = CacheHelper.getQuizAnswers(docId);
    if(cache != null){
      quizAnswers = cache;
      emit(OnResume());
      return;
    }else{
      quizAnswers =QuizAnswers(
        docId: docId,
        wednesday: DayAnswers(
            answers: [
              Answer(answer: -1,questionIndex: 0),
              Answer(answer: -1,questionIndex: 1),
              Answer(answer: -1,questionIndex: 2),
              Answer(answer: -1,questionIndex: 3),
              Answer(answer: -1,questionIndex: 4)
            ]
        ),
        thursday: DayAnswers(
            answers: [
              Answer(answer: -1,questionIndex: 0),
              Answer(answer: -1,questionIndex: 1),
              Answer(answer: -1,questionIndex: 2),
              Answer(answer: -1,questionIndex: 3),
              Answer(answer: -1,questionIndex: 4)
            ]
        ),
        friday: DayAnswers(
            answers: [
              Answer(answer: -1,questionIndex: 0),
              Answer(answer: -1,questionIndex: 1),
              Answer(answer: -1,questionIndex: 2),
              Answer(answer: -1,questionIndex: 3),
              Answer(answer: -1,questionIndex: 4)
            ]
        ),
        monday: DayAnswers(
            answers: [
              Answer(answer: -1,questionIndex: 0),
              Answer(answer: -1,questionIndex: 1),
              Answer(answer: -1,questionIndex: 2),
              Answer(answer: -1,questionIndex: 3),
              Answer(answer: -1,questionIndex: 4)
            ]
        ),
        saturday: DayAnswers(
            answers: [
              Answer(answer: -1,questionIndex: 0),
              Answer(answer: -1,questionIndex: 1),
              Answer(answer: -1,questionIndex: 2),
              Answer(answer: -1,questionIndex: 3),
              Answer(answer: -1,questionIndex: 4)
            ]
        ),
        sunday: DayAnswers(
            answers: [
              Answer(answer: -1,questionIndex: 0),
              Answer(answer: -1,questionIndex: 1),
              Answer(answer: -1,questionIndex: 2),
              Answer(answer: -1,questionIndex: 3),
              Answer(answer: -1,questionIndex: 4)
            ]
        ),
        tuesday: DayAnswers(
          answers: [
            Answer(answer: -1,questionIndex: 0),
            Answer(answer: -1,questionIndex: 1),
            Answer(answer: -1,questionIndex: 2),
            Answer(answer: -1,questionIndex: 3),
            Answer(answer: -1,questionIndex: 4)
          ],
        ),
      );
    }
  }

  void updateQuizAnswers(int questionIndex, int answer,String day){
    switch(day){
      case "Friday":{
        quizAnswers.friday?.answers?[questionIndex].answer = answer;
        emit(OnAnswer());
        break;
      }
      case "Monday":{
        quizAnswers.monday?.answers?[questionIndex].answer = answer;
        emit(OnAnswer());
        break;
      }
      case "Saturday":{
        quizAnswers.saturday?.answers?[questionIndex].answer = answer;
        emit(OnAnswer());
        break;
      }
      case "Sunday":{
        quizAnswers.sunday?.answers?[questionIndex].answer = answer;
        emit(OnAnswer());
        break;
      }
      case "Tuesday":{
        quizAnswers.tuesday?.answers?[questionIndex].answer = answer;
        emit(OnAnswer());
        break;
      }
      case "Wednesday":{
        quizAnswers.wednesday?.answers?[questionIndex].answer = answer;
        emit(OnAnswer());
        break;
      }
      case "Thursday":{
        quizAnswers.thursday?.answers?[questionIndex].answer = answer;
        emit(OnAnswer());
        break;
      }
    }
  }
  void onSaveAnswers()async{
    await CacheHelper.saveQuizAnswers(quizAnswers);
    emit(OnGetBack());
  }
  void onSubmit()async{
    for(var i = 0; i < 1; i++){
      if(quizAnswers.friday?.answers?[i].answer == quiz.friday?.questions?[i].correctAnswer){
        score++;
      }
      if(quizAnswers.saturday?.answers?[i].answer == quiz.saturday?.questions?[i].correctAnswer){
        score++;
      }
      if(quizAnswers.sunday?.answers?[i].answer == quiz.sunday?.questions?[i].correctAnswer){
        score++;
      }
      if(quizAnswers.monday?.answers?[i].answer == quiz.monday?.questions?[i].correctAnswer){
        score++;
      }
      if(quizAnswers.tuesday?.answers?[i].answer == quiz.tuesday?.questions?[i].correctAnswer){
        score++;
      }
      if(quizAnswers.wednesday?.answers?[i].answer == quiz.wednesday?.questions?[i].correctAnswer){
        score++;
      }
      if(quizAnswers.thursday?.answers?[i].answer == quiz.thursday?.questions?[i].correctAnswer){
        score++;
      }
    }
    try{
      userData.quizzes?.add(MemberQuizzesModel(docId: quiz.docId,degree: score));
      await usersUseCase.updateUser(UserModel(
          isAnyUpdate: false,
          version: FirebaseEndpoints.version,
          address: userData.address,
          admin: userData.admin,
          age: userData.age,
          birthday: userData.birthday,
          classId: userData.classId,
          date: userData.date,
          fatherName: userData.fatherName,
          uid: userData.uid,
          isAdmin: userData.admin,
          isShams: userData.isShams,
          isTeacher: userData.isTeacher,
          name: userData.name,
          parents: userData.parents,
          phone: userData.phone,
          profile: userData.profile,
          quizzes: userData.quizzes
      ));
      await CacheHelper.saveUserData(userData);
      emit(OnSubmit());
    }catch(e){
      emit(OnError());
    }
  }
}