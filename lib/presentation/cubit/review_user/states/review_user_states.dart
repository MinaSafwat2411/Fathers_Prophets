class ReviewUserStates {}

class InitialState extends ReviewUserStates{}

class OnLoadingState extends ReviewUserStates{}

class OnSuccessState extends ReviewUserStates{}

class OnErrorState extends ReviewUserStates{
  final String error;
  OnErrorState(this.error);
}

class OnReviewState extends ReviewUserStates{}

class OnClassSelectedState extends ReviewUserStates{}

class OnDeleteUser extends ReviewUserStates{}

class OnGetData extends ReviewUserStates{}

