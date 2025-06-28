import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/users/users_model.dart';
import '../../../../data/services/cache_helper.dart';
import '../states/dashboard_states.dart';

class DashboardCubit extends Cubit<DashboardStates> {
  DashboardCubit() : super(InitialStates());

  static DashboardCubit get(context) => BlocProvider.of(context);

  var members = <UserModel>[];
  var membersFiltered = <UserModel>[];
  var football = -1;
  var pingPong = -1;
  var volleyball = -1;
  var chess = -1;
  var doctrine = -1;
  var bible = -1;
  var coptic = -1;
  var melodies = -1;
  var ritual = -1;
  var choir = -1;
  var quizzes = -1;
  var shmas = -1;
  var odas = -1;
  var sundaySchool = -1;
  var tnawel = -1;
  var list = <String>[
    'bible',
    'coptic',
    'melodies',
    'ritual',
    'choir',
    'pingPong',
    'football',
    'volleyball',
    'chess',
    'doctrine',
    'quizzes',
  ];
  var selected = -1;

  void getAllData() {
    emit(OnLoading());
    bible = CacheHelper.getEvents('bible').length;
    coptic = CacheHelper.getEvents('coptic').length;
    melodies = CacheHelper.getEvents('melodies').length;
    ritual = CacheHelper.getEvents('ritual').length;
    choir = CacheHelper.getEvents('choir').length;
    pingPong = CacheHelper.getEvents('pingPong').length;
    football = CacheHelper.getEvents('football').length;
    volleyball = CacheHelper.getEvents('volleyball').length;
    chess = CacheHelper.getEvents('chess').length;
    doctrine = CacheHelper.getEvents('doctrine').length;
    quizzes = CacheHelper.getQuizzes().length;
    members = CacheHelper.getMembers();
    membersFiltered = members;
    emit(OnSuccess());
  }

  void onFilter(int index) {
    emit(OnLoading());
    if (selected == index) {
      selected = -1;
    } else {
      selected = index;
    }
    emit(OnFilter());
    switch (index) {
      case 0:
        membersFiltered.sort(
          (a, b) => (b.bible?.length ?? 0).compareTo(a.bible?.length ?? 0),
        );
        break;
      case 1:
        membersFiltered.sort(
          (a, b) => (b.coptic?.length ?? 0).compareTo(a.coptic?.length ?? 0),
        );
        break;
      case 2:
        membersFiltered.sort(
          (a, b) =>
              (b.melodies?.length ?? 0).compareTo(a.melodies?.length ?? 0),
        );
        break;
      case 3:
        membersFiltered.sort(
          (a, b) =>
              (b.ritual?.length ?? 0).compareTo(a.ritual?.length ?? 0),
        );
        break;
      case 4:
        membersFiltered.sort(
          (a, b) =>
              (b.choir?.length ?? 0).compareTo(a.choir?.length ?? 0),
        );
        break;
      case 5:
        membersFiltered.sort(
          (a, b) =>
              (b.pingPong?.length ?? 0).compareTo(a.pingPong?.length ?? 0),
        );
        break;
      case 6:
        membersFiltered.sort(
          (a, b) =>
              (b.football?.length ?? 0).compareTo(a.football?.length ?? 0),
        );
        break;
      case 7:
        membersFiltered.sort(
          (a, b) =>
              (b.volleyball?.length ?? 0).compareTo(a.volleyball?.length ?? 0),
        );
        break;
      case 8:
        membersFiltered.sort(
          (a, b) =>
              (b.chess?.length ?? 0).compareTo(a.chess?.length ?? 0),
        );
        break;
      case 9:
        membersFiltered.sort(
          (a, b) =>
              (b.doctrine?.length ?? 0).compareTo(a.doctrine?.length ?? 0),
        );
        break;
      case 10:
        membersFiltered.sort(
          (a, b) =>
              (b.quizzes?.length ?? 0).compareTo(a.quizzes?.length ?? 0),
        );
        break;
      case -1:
        membersFiltered = members;
        break;
    }
    emit(OnSuccess());
  }
}
