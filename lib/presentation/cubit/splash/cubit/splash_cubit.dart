import 'dart:async';

import 'package:fathers_prophets/core/constants/firebase_endpoints.dart';
import 'package:fathers_prophets/data/repositories/quizzes/quizzes_repository.dart';
import 'package:fathers_prophets/data/repositories/users/users_repository.dart';
import 'package:fathers_prophets/domain/usecases/classes/classes_use_case.dart';
import 'package:fathers_prophets/domain/usecases/quizzes/quizzes_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/classes/class_model.dart';
import '../../../../data/models/quizzes/quizzes_model.dart';
import '../../../../data/models/users/users_model.dart';
import '../../../../data/repositories/classes/class_repository.dart';
import '../../../../data/services/cache_helper.dart';
import '../../../../domain/usecases/users/users_use_case.dart';
import '../states/splash_states.dart';

class SplashCubit extends Cubit<SplashStates> {
  SplashCubit() : super(SplashInitialState());

  var servantList = <UserModel?>[];
  var classList = <ClassModel?>[];
  var memberList = <UserModel?>[];
  var quizzesList = <QuizzesModel?>[];
  var userData = UserModel();

  final UsersUseCase usersUseCase = UsersUseCase(UserRepository());
  final ClassesUseCase classesUseCase = ClassesUseCase(ClassRepository());
  final QuizzesUseCase questionsUseCase = QuizzesUseCase(QuizzesRepository());

  static SplashCubit get(context) => BlocProvider.of(context);

  void onNavigate(isDark, uid, isOpened) async {
      if (isOpened) {
        if (uid == '') {
          Future.delayed(const Duration(seconds: 3), () {
            emit(OnNavigateToLoginScreen());
          });
        } else {
          try {
            userData = await usersUseCase.getUserData(uid) ?? UserModel();
          await CacheHelper.saveUserData(userData);
          if ((userData.isAnyUpdate??false)) {
            await getAllFirebaseDate();
          }else if (!(FirebaseEndpoints.version == userData.version)) {
            emit(OnRequestUpToDate());
          }
          if(state is! OnRequestUpToDate){
            emit(OnNavigateToHomeScreen());
          }
          } catch (e) {
            emit(OnError(e.toString()));
          }
      }
    }else{
        Future.delayed(const Duration(seconds: 3), () {
          emit(OnNavigateToOnBoardingScreen());
        }
        );
      }
  }

  Future<void> getAllFirebaseDate() async {
    try {
      emit(OnLoading());
      servantList = (await usersUseCase.getAllServants()??[]);
      classList = (await classesUseCase.getAllClasses()??[]);
      memberList = (await usersUseCase.getAllMembers()??[]);
      quizzesList = (await questionsUseCase.getAllQuizzes()??[]);
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
      await CacheHelper.saveServants(servantList);
      await CacheHelper.saveClasses(classList);
      await CacheHelper.saveMembers(memberList);
      await CacheHelper.saveQuizzes(quizzesList);
      emit(OnSuccess());
    } catch (e) {
      emit(OnError(e.toString()));
    }
  }
}
