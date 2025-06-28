import 'package:fathers_prophets/data/repositories/auth/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/users/users_model.dart';
import '../../../../data/services/cache_helper.dart';
import '../../../../domain/usecases/auth/auth_use_case.dart';
import '../states/profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates>{
  ProfileCubit() : super(InitialStates());

  static ProfileCubit get(context) => BlocProvider.of(context);

  final authUseCase = AuthUseCase(AuthRepository());
  var user = UserModel();

  void getUserData()async{
    emit(LoadingStates());
    user = CacheHelper.getUserData();
    emit(SuccessStates());
  }

  void onSignOut()async{
    emit(LoadingStates());
    try{
      await authUseCase.logout();
      await CacheHelper.removeData(key: 'uid');
      emit(OnSignOut());
    }catch(e){
      emit(ErrorStates(message: e.toString()));
    }
  }
}