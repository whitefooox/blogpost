part of 'posts_bloc.dart';

@immutable
sealed class PostsEvent {}

final class PostsFetchEvent extends PostsEvent {}
