import 'package:fathers_prophets/data/models/attendance/attendance_model.dart';
import 'package:fathers_prophets/data/models/quizzes/quizzes_model.dart';
import 'package:fathers_prophets/data/models/users/users_model.dart';
import 'package:fathers_prophets/data/repositories/attendance/attendance_repository.dart';
import 'package:fathers_prophets/domain/usecases/attendance/attendance_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../data/models/events/events_model.dart';
import '../../../../data/repositories/quizzes_score/quizzes_score_repository.dart';
import '../../../../data/services/cache_helper.dart';
import '../../../../domain/usecases/quizzes_score/quizzes_score_use_case.dart';
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
  List<EventsModel> comingEvents = <EventsModel>[];
  List<EventsModel> filteredEvents = <EventsModel>[];
  List<EventsModel> allEvents = <EventsModel>[];


  final attendanceUseCase = AttendanceUseCase(AttendanceRepository());
  final QuizzesScoreUseCase quizzesScoreUseCase = QuizzesScoreUseCase(QuizzesScoreRepository());


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
      }else if(userData.isTeacher??false){
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

  void getAllData() async {
    emit(LoadingState());
    quizzes = CacheHelper.getQuizzes();
    footballEvents = CacheHelper.getEvents('football');
    comingEvents.addAll(footballEvents.where((element) => element.dateTime!.isAfter(DateTime.now().subtract(Duration(days: 1)))).toList());
    bibleEvents = CacheHelper.getEvents('bible');
    comingEvents.addAll(bibleEvents.where((element) => element.dateTime!.isAfter(DateTime.now().subtract(Duration(days: 1)))).toList());
    pingPongEvents = CacheHelper.getEvents('pingPong');
    comingEvents.addAll(pingPongEvents.where((element) => element.dateTime!.isAfter(DateTime.now().subtract(Duration(days: 1)))).toList());
    volleyballEvents = CacheHelper.getEvents('volleyball');
    comingEvents.addAll(volleyballEvents.where((element) => element.dateTime!.isAfter(DateTime.now().subtract(Duration(days: 1)))).toList());
    copticEvents = CacheHelper.getEvents('coptic');
    comingEvents.addAll(copticEvents.where((element) => element.dateTime!.isAfter(DateTime.now().subtract(Duration(days: 1)))).toList());
    choirEvents = CacheHelper.getEvents('choir');
    comingEvents.addAll(choirEvents.where((element) => element.dateTime!.isAfter(DateTime.now().subtract(Duration(days: 1)))).toList());
    melodiesEvents = CacheHelper.getEvents('melodies');
    comingEvents.addAll(melodiesEvents.where((element) => element.dateTime!.isAfter(DateTime.now().subtract(Duration(days: 1)))).toList());
    ritualEvents = CacheHelper.getEvents('ritual');
    comingEvents.addAll(ritualEvents.where((element) => element.dateTime!.isAfter(DateTime.now().subtract(Duration(days: 1)))).toList());
    doctrineEvents = CacheHelper.getEvents('doctrine');
    comingEvents.addAll(doctrineEvents.where((element) => element.dateTime!.isAfter(DateTime.now().subtract(Duration(days: 1)))).toList());
    chessEvents = CacheHelper.getEvents('chess');
    comingEvents.addAll(chessEvents.where((element) => element.dateTime!.isAfter(DateTime.now().subtract(Duration(days: 1)))).toList());
    prayEvents = CacheHelper.getEvents('pray');
    comingEvents.addAll(prayEvents.where((element) => element.dateTime!.isAfter(DateTime.now().subtract(Duration(days: 1)))).toList());
    praiseEvents = CacheHelper.getEvents('praise');
    comingEvents.addAll(praiseEvents.where((element) => element.dateTime!.isAfter(DateTime.now().subtract(Duration(days: 1)))).toList());
    filteredEvents.addAll(footballEvents+bibleEvents+pingPongEvents+volleyballEvents+copticEvents+choirEvents+melodiesEvents+ritualEvents+doctrineEvents+chessEvents+prayEvents+praiseEvents);
    filteredEvents.sort((a, b) => (b.dateTime?? DateTime.now()).compareTo(a.dateTime?? DateTime.now()));
    comingEvents.sort((a, b) => (b.dateTime?? DateTime.now()).compareTo(a.dateTime?? DateTime.now()));
    allEvents = filteredEvents;
    sortQuizzes();
    quizzesSearch = quizzes;
    emit(SuccessState());
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

  void getUserData()async{
    emit(LoadingState());
    userData = CacheHelper.getUserData();
    quizzesDone = await quizzesScoreUseCase.getQuizzesScoreById(userData.uid??'').then((value) => value?.quizzes??[]);
    emit(SuccessState());
  }
  void sortAttendance(){
    attendance.sort((a, b) => (b.date?? DateTime.now()).compareTo(a.date?? DateTime.now()));
    emit((SortAttendanceState()));
  }
  void sortQuizzes(){
    quizzes.sort((a, b) => (b.number??-1).compareTo(a.number??-1));
    emit((SortQuizzesState()));
  }
  void afterUpdateQuizzes(String docId){
    quizzesDone.add(docId);
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
      filteredEvents = allEvents;
      emit(OnSearchEventState());
    } else {
      filteredEvents= filteredEvents.where((element) => (element.title??"").contains(query)).toList();
      emit(OnSearchEventState());
    }
  }

  void canPreview()async{
    userData = userData.copyWith(
      isAdmin: !(userData.isAdmin??false),
      isTeacher: !(userData.isTeacher??false)
    );
    await CacheHelper.saveUserData(userData);
    emit(CanPreviewState());
  }
}
