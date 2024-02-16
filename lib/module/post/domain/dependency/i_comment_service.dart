import 'package:blogpost/module/post/domain/entity/comment.dart';

abstract class ICommentService {
  Future<List<Comment>> getComments(String postId); //получить комментарии поста
  Future<void> addComment(String postId, String text); //добавить комментарий к посту
}