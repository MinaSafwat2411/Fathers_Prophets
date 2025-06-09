import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;

import '../states/events_states.dart';

class EventsCubit extends Cubit<EventsStates>{
  EventsCubit() : super(InitialState());
  static EventsCubit get(context) => BlocProvider.of(context);

  void onLoadImages(){
    if(state is! OnLoading) {
      return;
    }else{
      emit(OnLoading());
    }
  }
  void onSuccess(){
    if(state is! OnSuccess) {
      emit(OnSuccess());
    }
  }
}