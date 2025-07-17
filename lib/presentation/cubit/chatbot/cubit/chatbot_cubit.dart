import 'package:bloc/bloc.dart';
import 'package:fathers_prophets/presentation/cubit/chatbot/states/chatbot_states.dart';
import 'package:flutter/cupertino.dart';

import '../../../../data/models/chatbot_model/chatbot_model.dart';
import '../../../../data/repositories/chatbot/chatbot_repository.dart';
import '../../../../domain/usecases/chatbot/chatbot_use_case.dart';

class ChatbotCubit extends Cubit<ChatbotStates>{
  ChatbotCubit() : super(ChatbotInitial());

  List<ChatbotModel> messages = <ChatbotModel>[];
  TextEditingController textController = TextEditingController();
  ChatbotUseCase chatbotUseCase = ChatbotUseCase(ChatbotRepository());

  void onClearChat(){
    messages.clear();
    emit(OnClearChat());
  }
  void onSendMessage()async{
    messages.add(ChatbotModel(message: textController.text, sender: true, time: DateTime.now()));
    textController.clear();
    emit(OnSendMessage());
    try{
      emit(OnLoadingMassage());
      var response = await chatbotUseCase.sendMessage(messages.last.message);
      messages.add(ChatbotModel(message: response, sender: false, time: DateTime.now()));
      emit(OnSuccess());
    }catch(e){
      emit(OnError(e.toString()));
    }
  }
}