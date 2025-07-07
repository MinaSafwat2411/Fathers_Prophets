class QuizTableStates {}

class OnLoading extends QuizTableStates{}

class OnSuccess extends QuizTableStates{}

class OnError extends QuizTableStates{
  final String error;
  OnError(this.error);
}

class OnSelectMember extends QuizTableStates{}

class OnSelectQuiz extends QuizTableStates{}

class OnSelectClass extends QuizTableStates{}

class OnSearch extends QuizTableStates{}