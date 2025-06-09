class EventsStates {}

class InitialState extends EventsStates{}

class OnLoading extends EventsStates{}

class OnSuccess extends EventsStates{}

class OnError extends EventsStates{
  final String error;
  OnError(this.error);
}