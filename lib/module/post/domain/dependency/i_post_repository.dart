import 'package:blogpost/module/post/domain/entity/post.dart';

abstract class IPostRepository {
  Future<List<Post>> getAll(); //получение всех постов
  Future<Post> getPostDetails(int id); //получение всей информации о посте
  Future<void> addPost(Post post); //добавить пост
  Future<void> deletePost(int id); //удалить пост
  Future<void> editPost(Post post); //редактировать пост
}