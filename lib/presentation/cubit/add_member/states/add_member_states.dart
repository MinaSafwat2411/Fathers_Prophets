class AddMemberStates {}

class InitialState extends AddMemberStates {}

class OnLoading extends AddMemberStates {}

class OnSuccess extends AddMemberStates {}

class OnError extends AddMemberStates {
  final String message;
  OnError(this.message);
}

class OnSelectClass extends AddMemberStates {}
