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

class OnSearchOpenState extends LayoutStates {}

class OnSearchCloseState extends LayoutStates {}

class UpdateAttendanceState extends LayoutStates {}

class UpdateQuizzesState extends LayoutStates {}

class SortQuizzesState extends LayoutStates {}

class SortAttendanceState extends LayoutStates {}