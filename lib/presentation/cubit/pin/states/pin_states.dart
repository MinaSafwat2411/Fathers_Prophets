class PinStates {}

class InitialState extends PinStates{}

class OnLoading extends PinStates{}

class OnSuccess extends PinStates{}

class OnError extends PinStates{
  final String error;
  OnError(this.error);
}

class OnPinChange extends PinStates{}

class OnWrongPin extends PinStates{}

class OnFullPin extends PinStates{}



