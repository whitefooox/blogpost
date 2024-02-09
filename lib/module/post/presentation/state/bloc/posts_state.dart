part of 'posts_bloc.dart';

sealed class PostsState {}

final class PostsInitial extends PostsState {}

final class PostsLoading extends PostsState {}

final class PostsLoaded extends PostsState {
  List<Post> posts;
  PostsLoaded(this.posts);
}

final class PostsError extends PostsState {
  String message;
  PostsError(this.message);
}
