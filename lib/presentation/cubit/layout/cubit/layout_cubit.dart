import 'package:fathers_prophets/data/models/attendance/attendance_model.dart';
import 'package:fathers_prophets/data/models/quizzes/quizzes_model.dart';
import 'package:fathers_prophets/data/models/users/member_quizzes_model.dart';
import 'package:fathers_prophets/data/models/users/users_model.dart';
import 'package:fathers_prophets/data/repositories/attendance/attendance_repository.dart';
import 'package:fathers_prophets/domain/usecases/attendance/attendance_use_case.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../data/services/cache_helper.dart';
import '../states/layout_states.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(InitialState());

  static LayoutCubit get(context) => BlocProvider.of(context);
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var pageController = PageController();
  var currentIndex = 0;
  var titles = ["home", "event", "quizzes", "attendance"];
  List<AttendanceModel> attendance = [];
  List<QuizzesModel> quizzes = [];
  List<QuizzesModel> quizzesSearch = [];
  var userData = UserModel();
  List<String> quizzesDone = [];

  final attendanceUseCase = AttendanceUseCase(AttendanceRepository());

  void onScreenChanged(int index) {
    currentIndex = index;
    pageController.jumpToPage(index);
    emit(OnChangeScreenState());
  }

  void onValueChange(int index) {
    currentIndex = index;
    emit(OnChangeScreenState());
  }

  String convertDateTimeToString(DateTime dateTime) {
    final DateFormat formatter = DateFormat("d-MMMM h:mm a");
    return formatter.format(dateTime);
  }

  void onLoadImage() {
    if (state is! LoadingState) emit(LoadingState());
  }

  void onImageSuccess() {
    if (state is! SuccessState) emit(SuccessState());
  }


  void getAllAttendance(String lang) async {
    try {
      emit(LoadingState());
      if(userData.isAdmin??false){
        attendance = await attendanceUseCase.getAllAttendance();
      }else{
        attendance = await attendanceUseCase.getAttendanceByClass(userData.classId??'');
      }
      for (var element in attendance) {
        element.dateView = formatDate(element.date?? DateTime.now(), lang);
      }
      attendance.sort((a, b) => (b.date?? DateTime.now()).compareTo(a.date?? DateTime.now()));
      emit(SuccessState());
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
  void getNewThemes(String lang) async {
    for (var element in attendance) {
      element.dateView = formatDate(element.date?? DateTime.now(), lang);
    }
    emit(SuccessState());
  }

  void getAllQuizzes() async {
    quizzes = CacheHelper.getQuizzes();
    sortQuizzes();
    quizzesSearch = quizzes;
  }

  static String formatDate(DateTime dateTime,String lang) {
    String locale = lang == "en" ? "en_US" : "ar_SA";
    DateFormat dateFormat = DateFormat("EEEE d - MMM", locale);
    return dateFormat.format(dateTime);
  }
  void afterUpdateAttendance(AttendanceModel? attendanceItem, int index) {
    if(attendanceItem != null){
      attendance[index] = attendanceItem;
    }
    emit(UpdateAttendanceState());
  }

  void getUserData(){
    userData = CacheHelper.getUserData();
    for(var item in userData.quizzes??<MemberQuizzesModel>[]){
      quizzesDone.add(item?.docId??'');
    }
  }
  void sortAttendance(){
    attendance.sort((a, b) => (b.date?? DateTime.now()).compareTo(a.date?? DateTime.now()));
    emit((SortAttendanceState()));
  }
  void sortQuizzes(){
    quizzes.sort((a, b) => (b.number??-1).compareTo(a.number??-1));
    emit((SortQuizzesState()));
  }
  void afterUpdateQuizzes(){
    getUserData();
    emit(UpdateQuizzesState());
  }

  void onSearchQuizClicked() {
    emit(OnSearchQuizOpenState());
  }

  void onSearchEventClicked() {
    emit(OnSearchEventOpenState());
  }

  void onSearchEventCloseClicked() {
    emit(OnSearchEventCloseState());
  }

  void onSearchQuizCloseClicked() {
    emit(OnSearchQuizCloseState());
  }

  void onSearchQuiz(String query) {
    if (query.isEmpty) {
      quizzesSearch = quizzes;
      emit(OnSearchQuizState());
    } else {
      quizzesSearch = quizzes.where((element) => element.number.toString().contains(query)).toList();
      emit(OnSearchQuizState());
    }
  }
  void onSearchEvent(String query) {
    if (query.isEmpty) {
      emit(OnSearchEventState());
    } else {
      emit(OnSearchEventState());
    }
  }
}
