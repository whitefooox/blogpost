import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blogpost/core/enum/loading_status.dart';
import 'package:blogpost/module/post/domain/interactor/post_interactor.dart';
import 'package:meta/meta.dart';

part 'edit_post_event.dart';
part 'edit_post_state.dart';

class EditPostBloc extends Bloc<EditPostEvent, EditPostState> {

  final PostInteractor _postInteractor;

  EditPostBloc(
    this._postInteractor,
  ) : super(EditPostState()) {
    on<EditPostLoadPostEvent>(_loadPost);
    on<EditPostUpdateTitleEvent>(_updateTitle);
    on<EditPostDeletePostEvent>(_deletePost);
    on<EditPostUpdateImageEvent>(_updateImage);
    on<EditPostUpdateContentEvent>(_updateContent);
    on<EditPostUpdatePublishEvent>(_updatePublish);
    on<EditPostSaveChangesEvent>(_saveChanges);
  }

  void _loadPost(
    EditPostLoadPostEvent event, 
    Emitter<EditPostState> emit
  ) async {
    try {
      final post = await _postInteractor.getPostDetails(event.postId);
      emit(state.copyWith(
        postId: post.id,
        title: post.title,
        content: post.content,
        imageUrl: post.imageUrl,
        isPublish: post.isPublished,
        loadingPostStatus: LoadingStatus.success
      ));
    } catch (e) {
      emit(state.copyWith(loadingPostStatus: LoadingStatus.failure));
    }
  }

  void _updateTitle(
    EditPostUpdateTitleEvent event, 
    Emitter<EditPostState> emit
  ) {
    emit(state.copyWith(title: event.title));
  }

  void _updateContent(
    EditPostUpdateContentEvent event, 
    Emitter<EditPostState> emit
  ) {
    emit(state.copyWith(content: event.content));
  }

  void _updatePublish(
    EditPostUpdatePublishEvent event, 
    Emitter<EditPostState> emit
  ) {
    emit(state.copyWith(isPublish: event.isPublish));
  }

  void _updateImage(
    EditPostUpdateImageEvent event, 
    Emitter<EditPostState> emit
  ) {
    emit(state.copyWith(newImagePath: event.imageUrl));
  }

  void _deletePost(
    EditPostDeletePostEvent event, 
    Emitter<EditPostState> emit
  ){
    try {
      _postInteractor.deletePost(state.postId);
    } catch (e) {
      log(e.toString());
    }
  }

  void _saveChanges(
    EditPostSaveChangesEvent event, 
    Emitter<EditPostState> emit
  ) async {
    try {
      await _postInteractor.updatePost(
        state.postId, 
        state.title,
        state.content, 
        state.isPublish, 
        state.newImagePath != null ? File(state.newImagePath!) : null
      );
    } catch (e) {
      log(e.toString());
    }
  }
}
