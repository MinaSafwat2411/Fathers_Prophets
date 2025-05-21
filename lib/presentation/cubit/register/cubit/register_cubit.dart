import 'package:fathers_prophets/data/models/users/users_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../states/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(InitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  var user = UserModel();
  void onRegister(){

  }
}