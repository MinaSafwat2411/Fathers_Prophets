import 'package:fathers_prophets/core/constants/firebase_endpoints.dart';
import 'package:fathers_prophets/data/models/auth/auth_model.dart';
import 'package:fathers_prophets/domain/usecases/events/events_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/classes/class_model.dart';
import '../../../../data/models/events/events_model.dart';
import '../../../../data/models/quizzes/quizzes_model.dart';
import '../../../../data/models/users/users_model.dart';
import '../../../../data/repositories/auth/auth_repository.dart';
import '../../../../data/repositories/classes/class_repository.dart';
import '../../../../data/repositories/events/events_repository.dart';
import '../../../../data/repositories/quizzes/quizzes_repository.dart';
import '../../../../data/repositories/splash/splash_repository.dart';
import '../../../../data/repositories/users/users_repository.dart';
import '../../../../data/services/cache_helper.dart';
import '../../../../data/services/google_drive_service.dart';
import '../../../../domain/usecases/auth/auth_use_case.dart';
import '../../../../domain/usecases/classes/classes_use_case.dart';
import '../../../../domain/usecases/quizzes/quizzes_use_case.dart';
import '../../../../domain/usecases/splash/splash_use_case.dart';
import '../../../../domain/usecases/users/users_use_case.dart';
import '../states/login_states.dart';

class LoginCubit extends Cubit<LoginStates>  {
  LoginCubit() : super(LoginInitialState());

  var servantList = <UserModel>[];
  var classList=<ClassModel>[];
  var memberList=<UserModel>[];
  var adminList=<UserModel>[];
  var quizzesList=<QuizzesModel?>[];
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
  var userData = UserModel();
  bool obscureText = true;

  final UsersUseCase usersUseCase = UsersUseCase(UserRepository());
  final ClassesUseCase classesUseCase = ClassesUseCase(ClassRepository());
  final QuizzesUseCase questionsUseCase = QuizzesUseCase(QuizzesRepository());
  final EventsUseCase eventsUseCase = EventsUseCase(EventsRepository());
  final SplashUseCase splashUseCase = SplashUseCase(SplashRepository());
  final GoogleDriveUploader uploader = GoogleDriveUploader();

  static LoginCubit get(context) => BlocProvider.of(context);

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final authUseCase = AuthUseCase(AuthRepository());
  var message = '';

  void login() async {
    emit(LoginLoadingState());
    if (formKey.currentState!.validate()) {
      var auth = AuthModel(
          email: emailController.text, password: passwordController.text);
      try {
        var uid = await authUseCase.login(auth);
        if(uid==null) {
          Future.delayed(Duration(seconds: 1),() => emit(LoginErrorState(
            message: "Couldn't Login, Please try again later."
          )),);
          return;
        }
        if ((await splashUseCase.getRequireToUpdate().then((value) => value.requireToUpdate ?? true,))) {
          emit(OnRequestUpToDate());
        }else{
          userData = await usersUseCase.getUserData(uid)??UserModel();
          await CacheHelper.saveUserData(userData);
          if((userData.isReviewed??false)) {
            if(userData.isAdmin??false){
              classList = await classesUseCase.getAllClasses();
              for(int i = 0; i<classList.length; i++){
                classList[i].members?.sort((a, b) => (a.name??"").compareTo(b.name??""));
              }
              await CacheHelper.saveClasses(classList);
            }
            await usersUseCase.updateUser(userData.copyWith(
              fcmToken: CacheHelper.getData(key: "fcmToken"),
            ));
            await getAllFirebaseDate();
            Future.delayed(Duration(seconds: 1),() => emit(LoginSuccessState()),);
          }else{
            Future.delayed(Duration(seconds: 1),() => emit(ToReviewState()),);
          }
        }
      } catch (e) {
        message = e.toString();
        emit(LoginErrorState(message: message));
      }
    }
  }
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
      await CacheHelper.removeEvents('mahrgan');
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
          mahrganEvents = (await eventsUseCase.getEventsByName(FirebaseEndpoints.mahrgan));
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
        case 'mahrgan':
          mahrganEvents = (await eventsUseCase.getEventsByName(FirebaseEndpoints.mahrgan));
          break;
        default: break;
      }
      quizzesList = (await questionsUseCase.getAllQuizzes()??[]);
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
      if(mahrganEvents.isNotEmpty) await CacheHelper.saveEvents(mahrganEvents, 'mahrgan');

    }catch(e){
      rethrow;
    }
  }

  void onObscureText(){
    obscureText = !obscureText;
    emit(OnObscureText());
  }
}
