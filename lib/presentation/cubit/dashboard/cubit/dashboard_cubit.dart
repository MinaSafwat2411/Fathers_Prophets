import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/users/users_model.dart';
import '../../../../data/services/cache_helper.dart';
import '../states/dashboard_states.dart';

class DashboardCubit extends Cubit<DashboardStates> {
  DashboardCubit() : super(InitialStates());

  static DashboardCubit get(context) => BlocProvider.of(context);

  UserModel userData = UserModel();
  List<UserModel> members = <UserModel>[];
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
  void getAllData() {
    emit(OnLoading());
    userData = CacheHelper.getUserData();
    members = [];
    // selectedClassName = CacheHelper.getClassByClassId(userData.classId??'').name;
    emit(OnSuccess());
  }
  void onSelectClass(String id){
    emit(OnLoading());
    members = CacheHelper.getMembersByClassId(id);
    emit(OnSuccess());
  }
}
