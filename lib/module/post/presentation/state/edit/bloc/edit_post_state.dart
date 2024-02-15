// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'edit_post_bloc.dart';

class EditPostState {
  //final Post? post;
  final String postId;
  final String title;
  final String content;
  final String imageUrl;
  final bool isPublish;
  final String? newImagePath;
  final LoadingStatus loadingPostStatus;

  EditPostState({
    this.postId = "",
    this.title = "",
    this.content = "",
    this.imageUrl = "",
    this.isPublish = false,
    this.newImagePath,
    this.loadingPostStatus = LoadingStatus.loading,
  });

  EditPostState copyWith({
    String? postId,
    String? title,
    String? content,
    String? imageUrl,
    bool? isPublish,
    LoadingStatus? loadingPostStatus,
    String? newImagePath
  }) {
    return EditPostState(
      postId: postId ?? this.postId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      isPublish: isPublish ?? this.isPublish,
      loadingPostStatus: loadingPostStatus ?? this.loadingPostStatus,
      newImagePath: newImagePath ?? this.newImagePath
    );
  }
}
