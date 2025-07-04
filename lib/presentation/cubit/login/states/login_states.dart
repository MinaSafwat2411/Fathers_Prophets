abstract class LoginStates {}

class LoginInitialState  extends LoginStates{}

class LoginLoadingState extends LoginStates{}

class LoginSuccessState extends LoginStates{}

class LoginErrorState extends LoginStates{
  final String message;
  LoginErrorState({required this.message});
}

class ToReviewState extends LoginStates{}

class OnObscureText extends LoginStates{}

class OnRequestUpToDate extends LoginStates{}
