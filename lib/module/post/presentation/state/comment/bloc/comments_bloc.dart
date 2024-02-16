import 'package:bloc/bloc.dart';
import 'package:blogpost/core/enum/loading_status.dart';
import 'package:blogpost/module/post/domain/entity/comment.dart';
import 'package:blogpost/module/post/domain/interactor/comment_interactor.dart';
import 'package:meta/meta.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {

  final CommentInteractor _commentInteractor;

  CommentsBloc(
    this._commentInteractor
  ) : super(CommentsState()) {
    on<CommentsLoadCommentsEvent>(_loadComments);
    on<CommentsAddCommentEvent>(_addComment);
  }

  void _loadComments(
    CommentsLoadCommentsEvent event, 
    Emitter<CommentsState> emit
  ) async {
    emit(state.copyWith(loadingStatus: LoadingStatus.loading, postId: event.postId));
    try {
      final comments = await _commentInteractor.getComments(event.postId);
      emit(state.copyWith(loadingStatus: LoadingStatus.success, comments: comments));
    } catch (e) {
      emit(state.copyWith(loadingStatus: LoadingStatus.failure));
    }
  }

  void _addComment(
    CommentsAddCommentEvent event, 
    Emitter<CommentsState> emit
  ) async {
    emit(state.copyWith(addCommentStatus: LoadingStatus.loading));
    try {
      await _commentInteractor.addComment(state.postId, event.comment);
      final comments = await _commentInteractor.getComments(state.postId);
      emit(state.copyWith(comments: comments, addCommentStatus: LoadingStatus.success));
    } catch (e) {
      emit(state.copyWith(addCommentStatus: LoadingStatus.failure));
    }
  }
}
