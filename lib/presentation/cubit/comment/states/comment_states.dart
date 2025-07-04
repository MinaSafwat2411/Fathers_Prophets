import '../../../../data/models/comment/comment_model.dart';

class CommentStates {}

class CommentInitial extends CommentStates {}

class CommentLoading extends CommentStates {}

class CommentLoaded extends CommentStates {
  final List<CommentModel> comments;
  CommentLoaded(this.comments);
}

class CommentError extends CommentStates {
  final String message;
  CommentError(this.message);
}

class CommentAdded extends CommentStates {}

class CommentDeleted extends CommentStates {}

class CommentUpdated extends CommentStates {}

class OnLoading extends CommentStates {}

class OnSuccess extends CommentStates {}

class OnError extends CommentStates {
  final String message;

  OnError(this.message);
}


