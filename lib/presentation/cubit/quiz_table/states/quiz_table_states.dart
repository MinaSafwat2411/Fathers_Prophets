class QuizTableStates {}

class OnLoading extends QuizTableStates{}

class OnSuccess extends QuizTableStates{}

class OnError extends QuizTableStates{
  final String error;
  OnError(this.error);
}