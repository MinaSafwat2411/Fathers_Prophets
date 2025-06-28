class ForgotPasswordStates {}

class InitialState extends ForgotPasswordStates{}

class OnLoading extends ForgotPasswordStates{}

class OnSuccess extends ForgotPasswordStates{}

class OnError extends ForgotPasswordStates{
  final String error;
  OnError(this.error);
}