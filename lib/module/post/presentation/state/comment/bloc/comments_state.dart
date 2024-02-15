// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'comments_bloc.dart';

class CommentsState {
  final LoadingStatus loadingStatus;
  final List<Comment> comments;

  CommentsState({
    this.loadingStatus = LoadingStatus.loading,
    this.comments = const [],
  });

  CommentsState copyWith({
    LoadingStatus? loadingStatus,
    List<Comment>? comments,
  }) {
    return CommentsState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      comments: comments ?? this.comments,
    );
  }
}
