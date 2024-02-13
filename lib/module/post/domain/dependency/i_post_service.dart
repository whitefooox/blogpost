import 'package:blogpost/module/post/domain/entity/post.dart';

abstract class IPostService {
  Future<List<Post>> getAll(); //получение всех постов
  Future<List<Post>> getMyPosts(); //получение постов пользователя
  Future<Post> getPostDetails(String id); //получение всей информации о посте
  Future<void> addPost(Post post); //добавить пост
  Future<void> deletePost(int id); //удалить пост
  Future<void> editPost(Post post); //редактировать пост
  Future<void> likePost(String id); //лайк поста
  Future<void> unlikePost(String id); //убрать лайк с поста
}