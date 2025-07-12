import 'dart:async';

import 'package:fathers_prophets/data/models/events/events_model.dart';
import 'package:fathers_prophets/data/repositories/events/events_repository.dart';
import 'package:fathers_prophets/data/repositories/quizzes/quizzes_repository.dart';
import 'package:fathers_prophets/data/repositories/users/users_repository.dart';
import 'package:fathers_prophets/domain/usecases/classes/classes_use_case.dart';
import 'package:fathers_prophets/domain/usecases/events/events_use_case.dart';
import 'package:fathers_prophets/domain/usecases/quizzes/quizzes_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/firebase_endpoints.dart';
import '../../../../data/models/classes/class_model.dart';
import '../../../../data/models/quizzes/quizzes_model.dart';
import '../../../../data/models/users/users_model.dart';
import '../../../../data/repositories/classes/class_repository.dart';
import '../../../../data/repositories/splash/splash_repository.dart';
import '../../../../data/services/cache_helper.dart';
import '../../../../data/services/google_drive_service.dart';
import '../../../../domain/usecases/splash/splash_use_case.dart';
import '../../../../domain/usecases/users/users_use_case.dart';
import '../states/splash_states.dart';

class SplashCubit extends Cubit<SplashStates> {
  SplashCubit() : super(SplashInitialState());

  var servantList = <UserModel>[];
  var memberList = <UserModel>[];
  var adminList = <UserModel>[];
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
  var prayEvents = <EventsModel>[];
  var praiseEvents = <EventsModel>[];
  var classList = <ClassModel>[];
  var userData = UserModel();

  final GoogleDriveUploader uploader = GoogleDriveUploader();
  final UsersUseCase usersUseCase = UsersUseCase(UserRepository());
  final ClassesUseCase classesUseCase = ClassesUseCase(ClassRepository());
  final QuizzesUseCase questionsUseCase = QuizzesUseCase(QuizzesRepository());
  final EventsUseCase eventsUseCase = EventsUseCase(EventsRepository());
  final SplashUseCase splashUseCase = SplashUseCase(SplashRepository());

  static SplashCubit get(context) => BlocProvider.of(context);

  Future<void> getAllFirebaseDate()async{
    try{
      await CacheHelper.removeQuizzes();
      await CacheHelper.removeEvents('bible');
      await CacheHelper.removeEvents('football');
      await CacheHelper.removeEvents('pingPong');
      await CacheHelper.removeEvents('volleyball');
      await CacheHelper.removeEvents('coptic');
      await CacheHelper.removeEvents('choir');
      await CacheHelper.removeEvents('melodies');
      await CacheHelper.removeEvents('ritual');
      await CacheHelper.removeEvents('doctrine');
      await CacheHelper.removeEvents('chess');
      await CacheHelper.removeEvents('pray');
      await CacheHelper.removeEvents('praise');
      switch(userData.role){
        case 'admin':
          footballEvents = (await eventsUseCase.getEventsByName(FirebaseEndpoints.football));
          bibleEvents = (await eventsUseCase.getEventsByName(FirebaseEndpoints.bible));
          pingPongEvents = (await eventsUseCase.getEventsByName(FirebaseEndpoints.pingPong));
          volleyballEvents = (await eventsUseCase.getEventsByName(FirebaseEndpoints.volleyball));
          copticEvents = (await eventsUseCase.getEventsByName(FirebaseEndpoints.coptic));
          choirEvents = (await eventsUseCase.getEventsByName(FirebaseEndpoints.choir));
          melodiesEvents = (await eventsUseCase.getEventsByName(FirebaseEndpoints.melodies));
          ritualEvents = (await eventsUseCase.getEventsByName(FirebaseEndpoints.ritual));
          doctrineEvents = (await eventsUseCase.getEventsByName(FirebaseEndpoints.doctrine));
          chessEvents = (await eventsUseCase.getEventsByName(FirebaseEndpoints.chess));
          prayEvents = (await eventsUseCase.getEventsByName(FirebaseEndpoints.pray));
          praiseEvents = (await eventsUseCase.getEventsByName(FirebaseEndpoints.praise));
          break;
        case 'sports':
          footballEvents = (await eventsUseCase.getEventsByName(FirebaseEndpoints.football));
          pingPongEvents = (await eventsUseCase.getEventsByName(FirebaseEndpoints.pingPong));
          volleyballEvents = (await eventsUseCase.getEventsByName(FirebaseEndpoints.volleyball));
          chessEvents = (await eventsUseCase.getEventsByName(FirebaseEndpoints.chess));
          break;
        case 'coptic':

          break;
        case 'choir':
          choirEvents = (await eventsUseCase.getEventsByName(FirebaseEndpoints.choir));
          break;
        case 'melodies':
          melodiesEvents = (await eventsUseCase.getEventsByName(FirebaseEndpoints.melodies));
          break;
        case 'ritual':
          ritualEvents = (await eventsUseCase.getEventsByName(FirebaseEndpoints.ritual));
          break;
        case 'doctrine':
          doctrineEvents = (await eventsUseCase.getEventsByName(FirebaseEndpoints.doctrine));
          break;
        case 'pray':
          prayEvents = (await eventsUseCase.getEventsByName(FirebaseEndpoints.pray));
          break;
        case 'praise':
          praiseEvents = (await eventsUseCase.getEventsByName(FirebaseEndpoints.praise));
          break;
        default: break;
      }
      quizzesList = (await questionsUseCase.getAllQuizzes()??[]);
      await usersUseCase.updateUser(userData.copyWith(
          isAnyUpdate: false
      ));
      if(quizzesList.isNotEmpty) await CacheHelper.saveQuizzes(quizzesList);
      if(bibleEvents.isNotEmpty) await CacheHelper.saveEvents(bibleEvents, 'bible');
      if(footballEvents.isNotEmpty) await CacheHelper.saveEvents(footballEvents, 'football');
      if(pingPongEvents.isNotEmpty) await CacheHelper.saveEvents(pingPongEvents, 'pingPong');
      if(volleyballEvents.isNotEmpty) await CacheHelper.saveEvents(volleyballEvents, 'volleyball');
      if(copticEvents.isNotEmpty) await CacheHelper.saveEvents(copticEvents, 'coptic');
      if(choirEvents.isNotEmpty) await CacheHelper.saveEvents(choirEvents, 'choir');
      if(melodiesEvents.isNotEmpty) await CacheHelper.saveEvents(melodiesEvents, 'melodies');
      if(ritualEvents.isNotEmpty) await CacheHelper.saveEvents(ritualEvents, 'ritual');
      if(doctrineEvents.isNotEmpty)await CacheHelper.saveEvents(doctrineEvents, 'doctrine');
      if(chessEvents.isNotEmpty) await CacheHelper.saveEvents(chessEvents, 'chess');
      if(prayEvents.isNotEmpty) await CacheHelper.saveEvents(prayEvents, 'pray');
      if(praiseEvents.isNotEmpty) await CacheHelper.saveEvents(praiseEvents, 'praise');

    }catch(e){
      rethrow;
    }
  }

  void onNavigate(isDark, uid, isOpened) async {
    if (isOpened) {
      if (uid == '') {
        Future.delayed(const Duration(seconds: 3), () {
          emit(OnNavigateToLoginScreen());
        });
      } else {
        try {
          if ((await splashUseCase.getRequireToUpdate().then((value) => value.requireToUpdate ?? true,))) {
            emit(OnRequestUpToDate());
          }else{
            emit(OnLoading());
            userData = await usersUseCase.getUserData(uid) ?? UserModel();
            await CacheHelper.saveUserData(userData);
            if ((userData.isReviewed ?? false)) {
              if(userData.isAdmin??false){
                classList = await classesUseCase.getAllClasses();
                for(int i = 0; i<classList.length; i++){
                  classList[i].members?.sort((a, b) => (a.name??"").compareTo(b.name??""));
                }
                await CacheHelper.saveClasses(classList);
              }
              await getAllFirebaseDate();
              emit(OnNavigateToHomeScreen());
            } else {
              Future.delayed(
                Duration(seconds: 3), () => emit(OnNavigateToReviewScreen()),);
            }
          }
        } catch (e) {
          emit(OnError(e.toString()));
        }
      }
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        emit(OnNavigateToOnBoardingScreen());
      }
      );
    }
  }
}
