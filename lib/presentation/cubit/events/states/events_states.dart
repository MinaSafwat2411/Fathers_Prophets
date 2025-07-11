class EventsStates {}

class InitialState extends EventsStates{}

class OnLoading extends EventsStates{}

class OnSuccess extends EventsStates{}

class OnError extends EventsStates{
  final String error;
  OnError(this.error);
}

class SelectEventState extends EventsStates{}

class OnAddMember extends EventsStates{}

class PickImageState extends EventsStates{}

class OnSelectDate extends EventsStates{}

class GetAllMembersState extends EventsStates{}

class OnRest extends EventsStates{}

class SearchState extends EventsStates{}

class OnBackDone extends EventsStates{}

class OnSearch extends EventsStates{}
