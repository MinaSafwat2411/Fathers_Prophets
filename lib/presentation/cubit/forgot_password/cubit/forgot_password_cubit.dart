import 'package:fathers_prophets/data/repositories/auth/auth_repository.dart';
import 'package:fathers_prophets/domain/usecases/auth/auth_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../states/forgot_password_states.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordStates>{
  ForgotPasswordCubit() : super(InitialState());

  static ForgotPasswordCubit get(context) => BlocProvider.of(context);

  AuthUseCase authUseCase = AuthUseCase(AuthRepository());
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