import 'dart:developer';

import 'package:blogpost/module/post/domain/dependency/i_comment_service.dart';
import 'package:blogpost/module/post/domain/entity/comment.dart';

class CommentInteractor {
  final ICommentService _commentService;

  CommentInteractor(this._commentService);

  Future<List<Comment>> getComments(String postId) async {
    log("comment interactor, get comments postId: $postId");
    return _commentService.getComments(postId);
  }

  Future<void> addComment(String postId, String text) async {
    log("comment interactor, add comment postId: $postId");
    return _commentService.addComment(postId, text);
  }
}