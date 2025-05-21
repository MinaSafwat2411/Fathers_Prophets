class RegisterStates {}

class InitialState extends RegisterStates{}

class OnLoadingState extends RegisterStates{}

class OnSuccessState extends RegisterStates{}

class OnErrorState extends RegisterStates{
  final String error;
  OnErrorState(this.error);
}

class OnRegisterState extends RegisterStates{}

class OnChangeScreen extends RegisterStates{}