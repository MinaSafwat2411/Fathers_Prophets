import 'package:fathers_prophets/data/models/chat/chat_model.dart';

class ChatPreviewModel {
  final String name;
  final String senderUid;
  final String receiverUid;
  final List<ChatModel> chats;

  ChatPreviewModel({
    required this.name,
    required this.senderUid,
    required this.receiverUid,
    required this.chats,
  });
}