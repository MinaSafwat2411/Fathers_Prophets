import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fathers_prophets/presentation/cubit/pin/states/pin_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/admin_pin/admin_pin_model.dart';
import '../../../../data/repositories/admin_pin/admin_pin_repository.dart';
import '../../../../domain/usecases/admin_pin/admin_pin_use_case.dart';
import '../../../../domain/usecases/admin_pin/i_admin_pin_use_case.dart';

class PinCubit extends Cubit<PinStates>{
  PinCubit(this.useCase) : super(InitialState());
  static PinCubit get(context) => BlocProvider.of(context);
  final IAdminPinUseCase useCase;
  String pin = '';
  void onSubmit() async {
    emit(OnLoading());
    try {
      final result = await useCase.checkAdminPin(AdminPinModel(pin: pin));
      pin = '';
      if (result) {
        emit(OnSuccess());
      } else {
        emit(OnWrongPin());
      }
    } on SocketException {
      emit(OnError('No internet connection. Please check your network.'));
    } on FirebaseException catch (e) {
      emit(OnError('Firebase error: ${e.message}'));
    } on Exception catch (e) {
      emit(OnError('Error: $e'));
    }
  }

  void onPinAdd(String value){
    pin += value;
    emit(OnPinChange());
  }

  void onPinRemove(){
    pin = pin.substring(0, pin.length - 1);
    emit(OnPinChange());
  }
}