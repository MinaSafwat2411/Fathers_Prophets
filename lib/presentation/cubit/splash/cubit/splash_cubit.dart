import 'dart:async';

import 'package:fathers_prophets/data/models/events/events_model.dart';
import 'package:fathers_prophets/data/repositories/events/events_repository.dart';
import 'package:fathers_prophets/data/repositories/quizzes/quizzes_repository.dart';
import 'package:fathers_prophets/data/repositories/users/users_repository.dart';
import 'package:intl/intl.dart';
import 'package:fathers_prophets/domain/usecases/classes/classes_use_case.dart';
import 'package:fathers_prophets/domain/usecases/events/events_use_case.dart';
import 'package:fathers_prophets/domain/usecases/quizzes/quizzes_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      await CacheHelper.removeAdmins();
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
          prayEvents = (await eventsUseCase.getPrayEvents());
          praiseEvents = (await eventsUseCase.getPraiseEvents());
          break;
        case 'sports':
          footballEvents = (await eventsUseCase.getFootballEvents());
          bibleEvents = (await eventsUseCase.getBibleEvents());
          pingPongEvents = (await eventsUseCase.getPingPongEvents());
          volleyballEvents = (await eventsUseCase.getVolleyballEvents());
          chessEvents = (await eventsUseCase.getChessEvents());
          break;
        case 'coptic':
          copticEvents = (await eventsUseCase.getCopticEvents());
          break;
        case 'choir':
          choirEvents = (await eventsUseCase.getChoirEvents());
          break;
        case 'melodies':
          melodiesEvents = (await eventsUseCase.getMelodiesEvents());
          break;
        case 'ritual':
          ritualEvents = (await eventsUseCase.getRitualEvents());
          break;
        case 'doctrine':
          doctrineEvents = (await eventsUseCase.getDoctrineEvents());
          break;
        case 'pray':
          prayEvents = (await eventsUseCase.getPrayEvents());
          break;
        case 'praise':
          praiseEvents = (await eventsUseCase.getPraiseEvents());
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
      print(e.toString());
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
            await CacheHelper.saveClasses(classList);
            if ((userData.isReviewed ?? false)) {
              await CacheHelper.removeMembers();
              await CacheHelper.removeMembersByClassId(classList[0].docId);
              await CacheHelper.removeMembersByClassId(classList[1].docId);
              await CacheHelper.removeMembersByClassId(classList[2].docId);
              await CacheHelper.removeMembersByClassId(classList[3].docId);
              await CacheHelper.removeMembersByClassId(classList[4].docId);
              await CacheHelper.removeMembersByClassId(classList[5].docId);
              await CacheHelper.removeMembersByClassId(classList[6].docId);
              await CacheHelper.removeMembersByClassId(classList[7].docId);
              await CacheHelper.removeServants();
              await CacheHelper.removeServantsByClassId(classList[0].docId);
              await CacheHelper.removeServantsByClassId(classList[1].docId);
              await CacheHelper.removeServantsByClassId(classList[2].docId);
              await CacheHelper.removeServantsByClassId(classList[3].docId);
              await CacheHelper.removeServantsByClassId(classList[4].docId);
              await CacheHelper.removeServantsByClassId(classList[5].docId);
              await CacheHelper.removeServantsByClassId(classList[6].docId);
              await CacheHelper.removeServantsByClassId(classList[7].docId);
              if(userData.isAdmin??false){
                memberList = (await uploader.getUsersFromFileById("13_UaD9tG4Gdo59f_WRHooGnNTzc55YmF"));
                memberList.sort((a, b) => (a.name??"").compareTo(b.name??""));
                servantList = (await uploader.getUsersFromFileById("1ZRKteCLH4oh2LRhqCmh3Sz7ZdCfSpFIm"));
                servantList.sort((a, b) => (a.name??"").compareTo(b.name??""));
                adminList = (await uploader.getUsersFromFileById("1e8uAyL3twahG6B-odWAxjpAo4VmAYDEc"));
                adminList.sort((a, b) => (a.name??"").compareTo(b.name??""));
              }
              if(servantList.isNotEmpty) {
                await CacheHelper.saveServants(servantList);
                await CacheHelper.saveServantsByClassId(servantList.where((element) => element.classId == classList[0].docId).toList(), classList[0].docId);
                await CacheHelper.saveServantsByClassId(servantList.where((element) => element.classId == classList[1].docId).toList(), classList[1].docId);
                await CacheHelper.saveServantsByClassId(servantList.where((element) => element.classId == classList[2].docId).toList(), classList[2].docId);
                await CacheHelper.saveServantsByClassId(servantList.where((element) => element.classId == classList[3].docId).toList(), classList[3].docId);
                await CacheHelper.saveServantsByClassId(servantList.where((element) => element.classId == classList[4].docId).toList(), classList[4].docId);
                await CacheHelper.saveServantsByClassId(servantList.where((element) => element.classId == classList[5].docId).toList(), classList[5].docId);
                await CacheHelper.saveServantsByClassId(servantList.where((element) => element.classId == classList[6].docId).toList(), classList[6].docId);
                await CacheHelper.saveServantsByClassId(servantList.where((element) => element.classId == classList[7].docId).toList(), classList[7].docId);
              }
              if (memberList.isNotEmpty) {
                await CacheHelper.saveMembers(memberList);
                await CacheHelper.saveMembersByClassId(memberList.where((element) => element.classId == classList[0].docId).toList(), classList[0].docId);
                await CacheHelper.saveMembersByClassId(memberList.where((element) => element.classId == classList[1].docId).toList(), classList[1].docId);
                await CacheHelper.saveMembersByClassId(memberList.where((element) => element.classId == classList[2].docId).toList(), classList[2].docId);
                await CacheHelper.saveMembersByClassId(memberList.where((element) => element.classId == classList[3].docId).toList(), classList[3].docId);
                await CacheHelper.saveMembersByClassId(memberList.where((element) => element.classId == classList[4].docId).toList(), classList[4].docId);
                await CacheHelper.saveMembersByClassId(memberList.where((element) => element.classId == classList[5].docId).toList(), classList[5].docId);
                await CacheHelper.saveMembersByClassId(memberList.where((element) => element.classId == classList[6].docId).toList(), classList[6].docId);
                await CacheHelper.saveMembersByClassId(memberList.where((element) => element.classId == classList[7].docId).toList(), classList[7].docId);
              }
              if(adminList.isNotEmpty) await CacheHelper.saveAdmins(adminList);
              if ((userData.isAnyUpdate ?? false)) {
                await getAllFirebaseDate();
              }
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
