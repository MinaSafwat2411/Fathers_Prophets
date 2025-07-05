import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/users/users_model.dart';
import '../../../../data/repositories/users/users_repository.dart';
import '../../../../data/services/cache_helper.dart';
import '../../../../domain/usecases/users/users_use_case.dart';
import '../states/dashboard_states.dart';

class DashboardCubit extends Cubit<DashboardStates> {
  DashboardCubit() : super(InitialStates());

  static DashboardCubit get(context) => BlocProvider.of(context);

  UserModel userData = UserModel();
  List<UserModel> members = <UserModel>[];
  List<UserModel> unReviewedMembers = <UserModel>[];
  final UsersUseCase usersUseCase = UsersUseCase(UserRepository());

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
    userData = CacheHelper.getUserData();
    members = [];
    await getUnReviewedMembers();
    emit(OnSuccess());
  }
  void onSelectClass(String id){
    emit(OnLoading());
    members = CacheHelper.getMembersByClassId(id);
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
