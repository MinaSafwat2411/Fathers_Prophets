abstract class SplashStates {}

class SplashInitialState extends SplashStates {}

class OnNavigateToLoginScreen  extends SplashStates {}

class OnNavigateToHomeScreen  extends SplashStates {}

class OnNavigateToOnBoardingScreen  extends SplashStates {}

class OnRequestUpToDate extends SplashStates{}

class OnLoading  extends SplashStates {}

class OnSuccess  extends SplashStates {}

class OnError  extends SplashStates {
  final String message;
  OnError(this.message);
}