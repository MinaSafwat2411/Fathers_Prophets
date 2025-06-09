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
import '../../../../data/repositories/users/users_repository.dart';
import '../../../../data/services/cache_helper.dart';
import '../../../../domain/usecases/auth/auth_use_case.dart';
import '../../../../domain/usecases/classes/classes_use_case.dart';
import '../../../../domain/usecases/quizzes/quizzes_use_case.dart';
import '../../../../domain/usecases/users/users_use_case.dart';
import '../states/login_states.dart';

class LoginCubit extends Cubit<LoginStates>  {
  LoginCubit() : super(LoginInitialState());

  var servantList = <UserModel?>[];
  var classList=<ClassModel?>[];
  var memberList=<UserModel?>[];
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

  final UsersUseCase usersUseCase = UsersUseCase(UserRepository());
  final ClassesUseCase classesUseCase = ClassesUseCase(ClassRepository());
  final QuizzesUseCase questionsUseCase = QuizzesUseCase(QuizzesRepository());
  final EventsUseCase eventsUseCase = EventsUseCase(EventsRepository());

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
        await getAllFirebaseDate(uid??"");
        emit(LoginSuccessState());
      } catch (e) {
        message = e.toString();
        emit(LoginErrorState(message: message));
      }
    }
  }
  Future<void> getAllFirebaseDate(String uid)async{
    try{
      servantList = (await usersUseCase.getAllServants()??[]);
      classList = (await classesUseCase.getAllClasses()??[]);
      memberList = (await usersUseCase.getAllMembers()??[]);
      quizzesList = (await questionsUseCase.getAllQuizzes()??[]);
      footballEvents = (await eventsUseCase.getFootballEvents());
      bibleEvents = (await eventsUseCase.getBibleEvents());
      pingPongEvents = (await eventsUseCase.getPingPongEvents());
      volleyballEvents = (await eventsUseCase.getVolleyballEvents());
      copticEvents = (await eventsUseCase.getCopticEvents());
      choirEvents = (await eventsUseCase.getChoirEvents());
      melodiesEvents = (await eventsUseCase.getMelodiesEvents());
      ritualEvents = (await eventsUseCase.getRitualEvents());
      if(servantList.isNotEmpty) await CacheHelper.saveServants(servantList);
      if(classList.isNotEmpty) await CacheHelper.saveClasses(classList);
      if(memberList.isNotEmpty) await CacheHelper.saveMembers(memberList);
      if(quizzesList.isNotEmpty) await CacheHelper.saveQuizzes(quizzesList);
      if(bibleEvents.isNotEmpty) await CacheHelper.saveEvents(bibleEvents, 'bible');
      if(footballEvents.isNotEmpty) await CacheHelper.saveEvents(footballEvents, 'football');
      if(pingPongEvents.isNotEmpty) await CacheHelper.saveEvents(pingPongEvents, 'pingPong');
      if(volleyballEvents.isNotEmpty) await CacheHelper.saveEvents(volleyballEvents, 'volleyball');
      if(copticEvents.isNotEmpty) await CacheHelper.saveEvents(copticEvents, 'coptic');
      if(choirEvents.isNotEmpty) await CacheHelper.saveEvents(choirEvents, 'choir');
      if(melodiesEvents.isNotEmpty) await CacheHelper.saveEvents(melodiesEvents, 'melodies');
      if(ritualEvents.isNotEmpty) await CacheHelper.saveEvents(ritualEvents, 'ritual');
      if(doctrineEvents.isNotEmpty) await CacheHelper.saveEvents(doctrineEvents, 'doctrine');
      if(chessEvents.isNotEmpty) await CacheHelper.saveEvents(chessEvents, 'chess');
      await CacheHelper.saveUserData(await usersUseCase.getUserData(uid)??UserModel());
    }catch(e){
      rethrow;
    }
  }
}
