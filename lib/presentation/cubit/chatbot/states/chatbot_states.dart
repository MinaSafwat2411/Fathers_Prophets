class ChatbotStates {}


class ChatbotInitial extends  ChatbotStates {}

class OnSendMessage extends  ChatbotStates {}

class OnLoadingMassage extends  ChatbotStates {}

class OnError extends  ChatbotStates {
  final String error;
  OnError(this.error);
}

class OnSuccess extends  ChatbotStates {}

class OnClearChat extends  ChatbotStates {}