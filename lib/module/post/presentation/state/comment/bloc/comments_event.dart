part of 'comments_bloc.dart';

@immutable
sealed class CommentsEvent {}

class CommentsLoadCommentsEvent implements CommentsEvent {
  final String postId;

  CommentsLoadCommentsEvent({
    required this.postId
  });
}

class CommentsAddCommentEvent implements CommentsEvent {
  final String comment;

  CommentsAddCommentEvent({
    required this.comment
  });
}