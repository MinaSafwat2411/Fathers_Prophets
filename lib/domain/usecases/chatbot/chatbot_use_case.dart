import 'package:fathers_prophets/domain/usecases/chatbot/i_chatbot_use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repositories/chatbot/i_chatbot_repository.dart';

@LazySingleton(as: IChatbotUseCase)
class ChatbotUseCase implements IChatbotUseCase {
  final IChatbotRepository chatbotRepository;

  ChatbotUseCase(this.chatbotRepository);

  @override
  Future<String> sendMessage(String message) async {
    return await chatbotRepository.sendMessage(message);
  }
}
