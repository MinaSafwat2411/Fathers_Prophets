abstract class ChatStates {}

class ChatInitial extends ChatStates {}

class ChatLoading extends ChatStates {}

class ChatUpdated extends ChatStates {} // just to notify UI

class ChatError extends ChatStates {
  final String message;
  ChatError(this.message);
}