import 'package:fathers_prophets/data/models/auth/auth_model.dart';
import 'package:fathers_prophets/data/models/quizzes_score/quizzes_score_model.dart';
import 'package:fathers_prophets/data/models/users/users_model.dart';
import 'package:fathers_prophets/data/repositories/users/users_repository.dart';
import 'package:fathers_prophets/domain/usecases/auth/auth_use_case.dart';
import 'package:fathers_prophets/domain/usecases/users/users_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/repositories/auth/auth_repository.dart';
import '../../../../data/repositories/eventattendance/event_attendance_repository.dart';
import '../../../../data/repositories/quizzes_score/quizzes_score_repository.dart';
import '../../../../domain/usecases/eventattendance/event_attendance_use_case.dart';
import '../../../../domain/usecases/quizzes_score/quizzes_score_use_case.dart';
import '../states/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(InitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  var user = UserModel();
  var currentIndex = 0;
  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  PageController pageController = PageController(
    initialPage: 0,
  );
  var selectedClass= "";
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  AuthUseCase authUseCase = AuthUseCase(AuthRepository());
  UsersUseCase usersUseCase = UsersUseCase(UserRepository());
  final QuizzesScoreUseCase quizzesScoreUseCase = QuizzesScoreUseCase(QuizzesScoreRepository());
  final EventAttendanceUseCase eventsAttendanceUseCase = EventAttendanceUseCase(EventAttendanceRepository());



  void onRegister()async{
    emit(OnLoadingState());
    try{
      final uid = await authUseCase.register(
          AuthModel(
              email: emailController.text,
              password: passwordController.text
          )
      );
      await usersUseCase.addNewMember(UserModel(
          uid: uid,
          name: nameController.text,
          isTeacher: false,
          isAdmin: false,
          isReviewed: false,
          classId: selectedClass,
          profile: "",
          checked: false,
          role: "member"
      ));
      await quizzesScoreUseCase.addQuizzesScore(uid, QuizzesScoreModel(name: nameController.text,score: 0,quizzes: []));
      clear();
      emit(OnSuccessState());
    }catch(e){
      emit(OnErrorState(e.toString()));
    }

  }
  void clear(){
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    currentIndex = 0;
  }
  void onNext()async{
      currentIndex++;
      await pageController.animateToPage(
        currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    emit(OnChangeScreen());
  }

  void onPrev()async{
    currentIndex--;
    await pageController.animateToPage(
      currentIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      );
    emit(OnChangeScreen());
  }
  void onClassSelected(String value){
    selectedClass = value;
    emit(OnClassSelected());
  }

  void onPasswordObscure(){
    isPasswordObscure = !isPasswordObscure;
    emit(OnPasswordObscure());
  }
  void onConfirmPasswordObscure(){
    isConfirmPasswordObscure = !isConfirmPasswordObscure;
    emit(OnConfirmPasswordObscure());
  }
}