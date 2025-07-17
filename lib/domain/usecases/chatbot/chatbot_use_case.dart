import '../../../data/repositories/chatbot/chatbot_repository.dart';

class ChatbotUseCase {
  final ChatbotRepository chatbotRepository;

  ChatbotUseCase(this.chatbotRepository);

  Future<String> sendMessage(String message) async {
    return await chatbotRepository.sendMessage(message);
  }
}