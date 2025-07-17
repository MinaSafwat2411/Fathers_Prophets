import 'package:firebase_ai/firebase_ai.dart';

class ChatbotRepository {
  final model = FirebaseAI.googleAI().generativeModel(model: 'gemini-2.5-flash');

  Future<String> sendMessage(String message) async {
    final prompt = [Content.text(message)];
    final response = await model.generateContent(prompt);
    return response.text??"";
  }
}