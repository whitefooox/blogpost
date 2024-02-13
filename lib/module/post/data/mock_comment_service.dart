import 'dart:developer';

import 'package:blogpost/module/post/domain/dependency/i_comment_service.dart';
import 'package:blogpost/module/post/domain/entity/comment.dart';

class MockCommentService  implements ICommentService {

  List<Comment> comments = [
    Comment(
      postId: "4",
      name: "Продавец", 
      surname: "гаража", 
      createdAt: DateTime.now(), 
      text: "Продам гараж"
    )
  ];

  @override
  Future<void> addComment(String postId) {
    // TODO: implement addComment
    throw UnimplementedError();
  }

  @override
  Future<List<Comment>> getComments(String postId) async {
    await Future.delayed(const Duration(seconds: 3));
    List<Comment> result = [];
    for (var comment in comments) { 
      if(comment.postId == postId){
        result.add(comment);
      }
    }
    log("mock comment service result lenght: ${result.length}");
    return result;
  }
}