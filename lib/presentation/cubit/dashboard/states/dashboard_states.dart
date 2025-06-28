class DashboardStates {}

class InitialStates extends DashboardStates{}

class OnLoading extends DashboardStates{}

class OnSuccess extends DashboardStates{}

class OnError extends DashboardStates{
  final String message;
  OnError(this.message);
}

class OnFilter extends DashboardStates{}