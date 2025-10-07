import 'dart:async';

import 'package:fathers_prophets/data/models/events/events_model.dart';
import 'package:fathers_prophets/data/repositories/events/events_repository.dart';
import 'package:fathers_prophets/data/repositories/quizzes/quizzes_repository.dart';
import 'package:fathers_prophets/data/repositories/users/users_repository.dart';
import 'package:fathers_prophets/data/services/cache/i_cache_helper.dart';
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
import '../../../../data/services/cache/cache_helper.dart';
import '../../../../data/services/drive/google_drive_service.dart';
import '../../../../data/services/drive/i_google_drive_service.dart';
import '../../../../domain/usecases/classes/i_classes_use_case.dart';
import '../../../../domain/usecases/events/i_events_use_case.dart';
import '../../../../domain/usecases/quizzes/i_quizzes_use_case.dart';
import '../../../../domain/usecases/splash/i_splash_use_case.dart';
import '../../../../domain/usecases/splash/splash_use_case.dart';
import '../../../../domain/usecases/users/i_users_use_case.dart';
import '../../../../domain/usecases/users/users_use_case.dart';
import '../states/splash_states.dart';

class SplashCubit extends Cubit<SplashStates> {
  SplashCubit(
    this.classesUseCase,
    this.splashUseCase,
    this.usersUseCase,
    this.eventsUseCase,
    this.questionsUseCase,
    this.cacheHelper,
    this.uploader,
  ) : super(SplashInitialState());

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
  var mahrganEvents = <EventsModel>[];
  var classList = <ClassModel>[];
  var userData = UserModel();

  final IGoogleDriveUploader uploader;
  final IUsersUseCase usersUseCase;
  final IClassesUseCase classesUseCase;
  final IQuizzesUseCase questionsUseCase;
  final IEventsUseCase eventsUseCase;
  final ISplashUseCase splashUseCase;
  final ICacheHelper cacheHelper;

  static SplashCubit get(context) => BlocProvider.of(context);

  Future<void> getAllFirebaseDate() async {
    try {
      await cacheHelper.removeQuizzes();
      await cacheHelper.removeEvents('bible');
      await cacheHelper.removeEvents('football');
      await cacheHelper.removeEvents('pingPong');
      await cacheHelper.removeEvents('volleyball');
      await cacheHelper.removeEvents('coptic');
      await cacheHelper.removeEvents('choir');
      await cacheHelper.removeEvents('melodies');
      await cacheHelper.removeEvents('ritual');
      await cacheHelper.removeEvents('doctrine');
      await cacheHelper.removeEvents('chess');
      await cacheHelper.removeEvents('pray');
      await cacheHelper.removeEvents('praise');
      await cacheHelper.removeEvents('mahrgan');
      switch (userData.role) {
        case 'admin':
          footballEvents = (await eventsUseCase.getEventsByName(
            FirebaseEndpoints.football,
          ));
          bibleEvents = (await eventsUseCase.getEventsByName(
            FirebaseEndpoints.bible,
          ));
          pingPongEvents = (await eventsUseCase.getEventsByName(
            FirebaseEndpoints.pingPong,
          ));
          volleyballEvents = (await eventsUseCase.getEventsByName(
            FirebaseEndpoints.volleyball,
          ));
          copticEvents = (await eventsUseCase.getEventsByName(
            FirebaseEndpoints.coptic,
          ));
          choirEvents = (await eventsUseCase.getEventsByName(
            FirebaseEndpoints.choir,
          ));
          melodiesEvents = (await eventsUseCase.getEventsByName(
            FirebaseEndpoints.melodies,
          ));
          ritualEvents = (await eventsUseCase.getEventsByName(
            FirebaseEndpoints.ritual,
          ));
          doctrineEvents = (await eventsUseCase.getEventsByName(
            FirebaseEndpoints.doctrine,
          ));
          chessEvents = (await eventsUseCase.getEventsByName(
            FirebaseEndpoints.chess,
          ));
          prayEvents = (await eventsUseCase.getEventsByName(
            FirebaseEndpoints.pray,
          ));
          praiseEvents = (await eventsUseCase.getEventsByName(
            FirebaseEndpoints.praise,
          ));
          mahrganEvents = (await eventsUseCase.getEventsByName(
            FirebaseEndpoints.mahrgan,
          ));
          break;
        case 'sports':
          footballEvents = (await eventsUseCase.getEventsByName(
            FirebaseEndpoints.football,
          ));
          pingPongEvents = (await eventsUseCase.getEventsByName(
            FirebaseEndpoints.pingPong,
          ));
          volleyballEvents = (await eventsUseCase.getEventsByName(
            FirebaseEndpoints.volleyball,
          ));
          chessEvents = (await eventsUseCase.getEventsByName(
            FirebaseEndpoints.chess,
          ));
          break;
        case 'coptic':
          break;
        case 'choir':
          choirEvents = (await eventsUseCase.getEventsByName(
            FirebaseEndpoints.choir,
          ));
          break;
        case 'melodies':
          melodiesEvents = (await eventsUseCase.getEventsByName(
            FirebaseEndpoints.melodies,
          ));
          break;
        case 'ritual':
          ritualEvents = (await eventsUseCase.getEventsByName(
            FirebaseEndpoints.ritual,
          ));
          break;
        case 'doctrine':
          doctrineEvents = (await eventsUseCase.getEventsByName(
            FirebaseEndpoints.doctrine,
          ));
          break;
        case 'pray':
          prayEvents = (await eventsUseCase.getEventsByName(
            FirebaseEndpoints.pray,
          ));
          break;
        case 'praise':
          praiseEvents = (await eventsUseCase.getEventsByName(
            FirebaseEndpoints.praise,
          ));
          break;
        case 'mahrgan':
          mahrganEvents = (await eventsUseCase.getEventsByName(
            FirebaseEndpoints.mahrgan,
          ));
          break;
        default:
          break;
      }
      quizzesList = (await questionsUseCase.getAllQuizzes() ?? []);
      if (quizzesList.isNotEmpty) await cacheHelper.saveQuizzes(quizzesList);
      if (bibleEvents.isNotEmpty)
        await cacheHelper.saveEvents(bibleEvents, 'bible');
      if (footballEvents.isNotEmpty)
        await cacheHelper.saveEvents(footballEvents, 'football');
      if (pingPongEvents.isNotEmpty)
        await cacheHelper.saveEvents(pingPongEvents, 'pingPong');
      if (volleyballEvents.isNotEmpty)
        await cacheHelper.saveEvents(volleyballEvents, 'volleyball');
      if (copticEvents.isNotEmpty)
        await cacheHelper.saveEvents(copticEvents, 'coptic');
      if (choirEvents.isNotEmpty)
        await cacheHelper.saveEvents(choirEvents, 'choir');
      if (melodiesEvents.isNotEmpty)
        await cacheHelper.saveEvents(melodiesEvents, 'melodies');
      if (ritualEvents.isNotEmpty)
        await cacheHelper.saveEvents(ritualEvents, 'ritual');
      if (doctrineEvents.isNotEmpty)
        await cacheHelper.saveEvents(doctrineEvents, 'doctrine');
      if (chessEvents.isNotEmpty)
        await cacheHelper.saveEvents(chessEvents, 'chess');
      if (prayEvents.isNotEmpty)
        await cacheHelper.saveEvents(prayEvents, 'pray');
      if (praiseEvents.isNotEmpty)
        await cacheHelper.saveEvents(praiseEvents, 'praise');
      if (mahrganEvents.isNotEmpty)
        await cacheHelper.saveEvents(mahrganEvents, 'mahrgan');
    } catch (e) {
      rethrow;
    }
  }

  void onNavigate() async {
    var uid = cacheHelper.getData(key: "uid") ?? '';
    var isOpened = cacheHelper.getData(key: "isOpened") ?? false;
    if (isOpened) {
      if (uid == '') {
        Future.delayed(const Duration(seconds: 3), () {
          emit(OnNavigateToLoginScreen());
        });
      } else {
        try {
          if ((await splashUseCase.getRequireToUpdate().then(
            (value) => value.requireToUpdate ?? true,
          ))) {
            emit(OnRequestUpToDate());
          } else {
            emit(OnLoading());
            userData = await usersUseCase.getUserData(uid) ?? UserModel();
            await cacheHelper.saveUserData(userData);
            if ((userData.isReviewed ?? false)) {
              if (userData.isAdmin ?? false) {
                classList = await classesUseCase.getAllClasses();
                for (int i = 0; i < classList.length; i++) {
                  classList[i].members?.sort(
                    (a, b) => (a.name ?? "").compareTo(b.name ?? ""),
                  );
                }
                await cacheHelper.saveClasses(classList);
              }
              await usersUseCase.updateUser(
                userData.copyWith(
                  fcmToken: cacheHelper.getData(key: "fcmToken"),
                ),
              );
              await getAllFirebaseDate();
              emit(OnNavigateToHomeScreen());
            } else {
              Future.delayed(
                Duration(seconds: 3),
                () => emit(OnNavigateToReviewScreen()),
              );
            }
          }
        } catch (e) {
          emit(OnError(e.toString()));
        }
      }
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        emit(OnNavigateToOnBoardingScreen());
      });
    }
  }
}
