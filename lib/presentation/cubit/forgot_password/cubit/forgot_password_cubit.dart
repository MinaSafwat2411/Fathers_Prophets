import 'package:fathers_prophets/domain/usecases/auth/i_auth_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../states/forgot_password_states.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordStates>{
  ForgotPasswordCubit(this.authUseCase) : super(InitialState());
  final IAuthUseCase authUseCase;
  static ForgotPasswordCubit get(context) => BlocProvider.of(context);


  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> forgotPassword() async {
    emit(OnLoading());
    try {
      await authUseCase.sendPasswordResetEmail(emailController.text);
      emit(OnSuccess());
    } catch (e) {
      emit(OnError(e.toString()));
    }
  }
}