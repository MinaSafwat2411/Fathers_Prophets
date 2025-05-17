class ProfileStates {}

class InitialStates extends ProfileStates{}

class ErrorStates extends ProfileStates{
  final String message;
  ErrorStates({required this.message});
}

class SuccessStates extends ProfileStates{}

class LoadingStates extends ProfileStates{}

class OnSignOut extends ProfileStates{}