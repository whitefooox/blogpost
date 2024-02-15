part of 'edit_post_bloc.dart';

@immutable
sealed class EditPostEvent {}

final class EditPostLoadPostEvent implements EditPostEvent {
  final String postId;

  EditPostLoadPostEvent({
    required this.postId
  });
}

final class EditPostUpdateTitleEvent implements EditPostEvent {
  final String title;

  EditPostUpdateTitleEvent({
    required this.title
  });
}

final class EditPostDeletePostEvent implements EditPostEvent {}

final class EditPostUpdateImageEvent implements EditPostEvent {
  final String imageUrl;

  EditPostUpdateImageEvent({
    required this.imageUrl
  });
}

final class EditPostUpdateContentEvent implements EditPostEvent {
  final String content;

  EditPostUpdateContentEvent({
    required this.content
  });
}

final class EditPostUpdatePublishEvent implements EditPostEvent {
  final bool isPublish;

  EditPostUpdatePublishEvent({
    required this.isPublish
  });
}

final class EditPostSaveChangesEvent implements EditPostEvent {}