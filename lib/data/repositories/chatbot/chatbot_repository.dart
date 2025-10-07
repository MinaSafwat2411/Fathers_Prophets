import 'package:firebase_ai/firebase_ai.dart';
import 'package:injectable/injectable.dart';

import 'i_chatbot_repository.dart';

@LazySingleton(as: IChatbotRepository)
class ChatbotRepository implements IChatbotRepository{
  final model = FirebaseAI.googleAI().generativeModel(model: 'gemini-2.5-flash');

  @override
  Future<String> sendMessage(String message) async {
    final prompt = [Content.text(message)];
    final response = await model.generateContent(prompt);
    return response.text??"";
  }
}