class QuizzesStates {}

class InitialState extends QuizzesStates{}

class OnSuccess extends QuizzesStates{}

class OnError extends QuizzesStates{
  final String error;
  OnError(this.error);
}

class OnLoading extends QuizzesStates{}

class OnAnswer extends QuizzesStates{}

class OnSubmit extends QuizzesStates{}

class OnCancel extends QuizzesStates{}

class OnRetry extends QuizzesStates{}

class OnClose extends QuizzesStates{}

class OnOpen extends QuizzesStates{}

class OnResume extends QuizzesStates{}

class OnPause extends QuizzesStates{}

class OnComplete extends QuizzesStates{}

class OnProgress extends QuizzesStates{}

class OnGetBack extends QuizzesStates{}

class OnSelectDate extends QuizzesStates{}

class OnAddQuestion extends QuizzesStates{}

class OnQuestionIndexIncrease extends QuizzesStates{}

class OnQuestionIndexDecrease extends QuizzesStates{}

class OnQuestionControllerChange extends QuizzesStates{}

class OnLimitQuestions extends QuizzesStates{}

class OnResetAll extends QuizzesStates{}

class OnShahid extends QuizzesStates{}

class OnReview extends QuizzesStates{}