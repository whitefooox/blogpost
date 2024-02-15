import 'dart:io';

import 'package:blogpost/module/post/domain/entity/post.dart';

abstract class IPostService {
  Future<List<Post>> getAll(); //получение всех постов
  Future<List<Post>> getMyPosts(); //получение постов пользователя
  Future<Post> getPostDetails(String postId); //получение всей информации о посте
  Future<void> addPost(
    String title, 
    String content, 
    bool isPublished, 
    File image
  ); //добавить пост
  Future<void> updatePost(
    String postId, 
    String? title, 
    String? content, 
    bool? isPublished, 
    File? image
  ); //обновить пост
  Future<void> deletePost(String postId); //удалить пост
  Future<void> editPost(Post post); //редактировать пост
  Future<void> likePost(String postId); //лайк поста
  Future<void> unlikePost(String postId); //убрать лайк с поста
}