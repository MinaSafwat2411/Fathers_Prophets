import 'package:fathers_prophets/data/models/auth/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/classes/class_model.dart';
import '../../../../data/models/quizzes/quizzes_model.dart';
import '../../../../data/models/users/users_model.dart';
import '../../../../data/repositories/auth/auth_repository.dart';
import '../../../../data/repositories/classes/class_repository.dart';
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

  final UsersUseCase usersUseCase = UsersUseCase(UserRepository());
  final ClassesUseCase classesUseCase = ClassesUseCase(ClassRepository());
  final QuizzesUseCase questionsUseCase = QuizzesUseCase(QuizzesRepository());

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
      await CacheHelper.saveServants(servantList);
      await CacheHelper.saveClasses(classList);
      await CacheHelper.saveMembers(memberList);
      await CacheHelper.saveQuizzes(quizzesList);
      await CacheHelper.saveUserData(await usersUseCase.getUserData(uid)??UserModel());
    }catch(e){
      rethrow;
    }
  }
}
