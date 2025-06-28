import 'dart:async';

import 'package:fathers_prophets/core/constants/firebase_endpoints.dart';
import 'package:fathers_prophets/data/models/events/events_model.dart';
import 'package:fathers_prophets/data/repositories/events/events_repository.dart';
import 'package:fathers_prophets/data/repositories/quizzes/quizzes_repository.dart';
import 'package:fathers_prophets/data/repositories/users/users_repository.dart';
import 'package:fathers_prophets/domain/usecases/classes/classes_use_case.dart';
import 'package:fathers_prophets/domain/usecases/events/events_use_case.dart';
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
  var memberList = <UserModel?>[];
  var adminList = <UserModel?>[];
  var quizzesList = <QuizzesModel?>[];
  var footballEvents = <EventsModel>[];
  var bibleEvents = <EventsModel>[];
  var pingPongEvents = <EventsModel>[];
  var volleyballEvents = <EventsModel>[];
  var copticEvents = <EventsModel>[];
  var choirEvents = <EventsModel>[];
  var melodiesEvents = <EventsModel>[];
  var ritualEvents = <EventsModel>[];
  var doctrineEvents = <EventsModel>[];
  var chessEvents = <EventsModel>[];
  var classList=<ClassModel>[];
  var userData = UserModel();

  final UsersUseCase usersUseCase = UsersUseCase(UserRepository());
  final ClassesUseCase classesUseCase = ClassesUseCase(ClassRepository());
  final QuizzesUseCase questionsUseCase = QuizzesUseCase(QuizzesRepository());
  final EventsUseCase eventsUseCase = EventsUseCase(EventsRepository());

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
          classList = [
            ClassModel(
                docId: "2uli6QXyKY8VrpjMz99H",
                name: "ابونا ابراهيم"
            ),
            ClassModel(
                docId: "8aB4mDsvky0FbzOQwfTU",
                name: "دانيال النبي"
            ),
            ClassModel(
                docId: "9l6zfZIO1C6OavYCvuRV",
                name: "امنا سارة"
            ),
            ClassModel(
                docId: "bCkH6KkCRnEDMk5Ea6sf",
                name: "حنه النبيه"
            ),
            ClassModel(
                docId: "el2A2Mjm45SU5jliE29g",
                name: "دبورة النبية"
            ),
            ClassModel(
                docId: "f0nBkPZu9OJbQ0Hstqij",
                name: "امنا رفقة"
            ),
            ClassModel(
                docId: "fE4xWCz3bvBhyZeMuk7g",
                name: "ابونا اسحق"
            ),
            ClassModel(
                docId: "nXB5fzKgjVkIrVrXrLDo",
                name: "موسي النبي"
            ),
          ];
          if(classList.isNotEmpty) {
            await CacheHelper.saveClasses(classList);
          }else{
            await CacheHelper.removeClasses();
          }
          if((userData.isReviewed??false)) {
            if ((userData.isAnyUpdate??false)) {
              await getAllFirebaseDate();
            }else if (!(FirebaseEndpoints.version == userData.version)) {
              emit(OnRequestUpToDate());
            }
            if(state is! OnRequestUpToDate){
              emit(OnNavigateToHomeScreen());
            }
          }else{
            Future.delayed(Duration(seconds: 3),() => emit(OnNavigateToReviewScreen()),);
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
      if(userData.isAdmin??false){
        servantList = (await usersUseCase.getAllServants()??[]);
        memberList = (await usersUseCase.getAllMembers()??[]);
        adminList = (await usersUseCase.getAllAdmins()??[]);
      }
      quizzesList = (await questionsUseCase.getAllQuizzes()??[]);
      footballEvents = (await eventsUseCase.getFootballEvents());
      bibleEvents = (await eventsUseCase.getBibleEvents());
      pingPongEvents = (await eventsUseCase.getPingPongEvents());
      volleyballEvents = (await eventsUseCase.getVolleyballEvents());
      copticEvents = (await eventsUseCase.getCopticEvents());
      choirEvents = (await eventsUseCase.getChoirEvents());
      melodiesEvents = (await eventsUseCase.getMelodiesEvents());
      ritualEvents = (await eventsUseCase.getRitualEvents());
      doctrineEvents = (await eventsUseCase.getDoctrineEvents());
      chessEvents = (await eventsUseCase.getChessEvents());
      await usersUseCase.updateUser(userData.copyWith(
          isAnyUpdate: false
      ));
      if(userData.isAdmin??false){
        if(servantList.isNotEmpty) {
          await CacheHelper.saveServants(servantList);
        }else{
          await CacheHelper.removeServants();
        }
        if(adminList.isNotEmpty) {
          await CacheHelper.saveAdmins(adminList);
        }else{
          await CacheHelper.removeAdmins();
        }
        if(memberList.isNotEmpty) {
          await CacheHelper.saveMembers(memberList);
        }else{
          await CacheHelper.removeMembers();
        }
      }
      if(quizzesList.isNotEmpty) {
        await CacheHelper.saveQuizzes(quizzesList);
      }else{
        await CacheHelper.removeQuizzes();
      }
      if(bibleEvents.isNotEmpty) {
        await CacheHelper.saveEvents(bibleEvents, 'bible');
      }else{
        await CacheHelper.removeEvents('bible');
      }
      if(footballEvents.isNotEmpty) {
        await CacheHelper.saveEvents(footballEvents, 'football');
      }else{
        await CacheHelper.removeEvents('football');
      }
      if(pingPongEvents.isNotEmpty) {
        await CacheHelper.saveEvents(pingPongEvents, 'pingPong');
      }else{
        await CacheHelper.removeEvents('pingPong');
      }
      if(volleyballEvents.isNotEmpty) {
        await CacheHelper.saveEvents(volleyballEvents, 'volleyball');
      }else{
        await CacheHelper.removeEvents('volleyball');
      }
      if(copticEvents.isNotEmpty) {
        await CacheHelper.saveEvents(copticEvents, 'coptic');
      }else{
        await CacheHelper.removeEvents('coptic');
      }
      if(choirEvents.isNotEmpty) {
        await CacheHelper.saveEvents(choirEvents, 'choir');
      }else{
        await CacheHelper.removeEvents('choir');
      }
      if(melodiesEvents.isNotEmpty) {
        await CacheHelper.saveEvents(melodiesEvents, 'melodies');
      }else{
        await CacheHelper.removeEvents('melodies');
      }
      if(ritualEvents.isNotEmpty) {
        await CacheHelper.saveEvents(ritualEvents, 'ritual');
      }else{
        await CacheHelper.removeEvents('ritual');
      }
      if(doctrineEvents.isNotEmpty) {
        await CacheHelper.saveEvents(doctrineEvents, 'doctrine');
      }else{
        await CacheHelper.removeEvents('doctrine');
      }
      if(chessEvents.isNotEmpty) {
        await CacheHelper.saveEvents(chessEvents, 'chess');
      }else{
        await CacheHelper.removeEvents('chess');
      }
      emit(OnSuccess());
    } catch (e) {
      emit(OnError(e.toString()));
    }
  }
}
