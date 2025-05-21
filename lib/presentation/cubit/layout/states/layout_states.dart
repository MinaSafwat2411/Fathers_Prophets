class LayoutStates {}

class InitialState extends LayoutStates {}

class LoadingState extends LayoutStates {}

class ErrorState extends LayoutStates {
  final String message;
  ErrorState(this.message);
}

class SuccessState extends LayoutStates {}

class OnChangeScreenState extends LayoutStates {}

class OnChangeLanguageState extends LayoutStates {}

class OnChangeThemeState extends LayoutStates {}


class UpdateAttendanceState extends LayoutStates {}

class UpdateQuizzesState extends LayoutStates {}

class SortQuizzesState extends LayoutStates {}

class SortAttendanceState extends LayoutStates {}

class OnSearchQuizOpenState extends LayoutStates {}

class OnSearchQuizCloseState extends LayoutStates {}

class OnSearchQuizState extends LayoutStates {}

class OnSearchEventState extends LayoutStates {}

class OnSearchEventOpenState extends LayoutStates {}

class OnSearchEventCloseState extends LayoutStates {}

