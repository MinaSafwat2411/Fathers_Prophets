import 'package:fathers_prophets/data/models/classes/class_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/users/users_model.dart';
import '../../../../data/repositories/users/users_repository.dart';
import '../../../../data/services/cache/i_cache_helper.dart';
import '../../../../domain/usecases/users/i_users_use_case.dart';
import '../../../../domain/usecases/users/users_use_case.dart';
import '../states/dashboard_states.dart';

class DashboardCubit extends Cubit<DashboardStates> {
  DashboardCubit(this.usersUseCase, this.cacheHelper) : super(InitialStates());

  final ICacheHelper cacheHelper;
  static DashboardCubit get(context) => BlocProvider.of(context);

  UserModel userData = UserModel();
  List<ClassModel> classes = <ClassModel>[];
  ClassModel selectedClass = ClassModel();
  List<UserModel> unReviewedMembers = <UserModel>[];
  final IUsersUseCase usersUseCase;

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
  void getAllData()async {
    emit(OnLoading());
    userData = cacheHelper.getUserData();
    classes = cacheHelper.getClasses();
    await getUnReviewedMembers();
    emit(OnSuccess());
  }
  void onSelectClass(ClassModel item){
    emit(OnLoading());
    selectedClass = item;
    emit(OnSuccess());
  }

  Future<void> getUnReviewedMembers()async{
    try{
      unReviewedMembers = (await usersUseCase.getNotReviewedUsers()??[]);
    }catch(e){
      emit(OnError(e.toString()));
    }
  }
}
