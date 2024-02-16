// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'comments_bloc.dart';

class CommentsState {
  final String postId;
  final LoadingStatus loadingStatus;
  final List<Comment> comments;
  final LoadingStatus addCommentStatus;

  CommentsState({
    this.postId = '',
    this.loadingStatus = LoadingStatus.loading,
    this.comments = const [],
    this.addCommentStatus = LoadingStatus.initial
  });

  CommentsState copyWith({
    String? postId,
    LoadingStatus? loadingStatus,
    List<Comment>? comments,
    LoadingStatus? addCommentStatus,
  }) {
    return CommentsState(
      postId: postId ?? this.postId,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      comments: comments ?? this.comments,
      addCommentStatus: addCommentStatus ?? this.addCommentStatus,
    );
  }
}
