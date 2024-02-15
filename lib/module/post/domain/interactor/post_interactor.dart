import 'dart:io';

import 'package:blogpost/module/post/domain/dependency/i_post_service.dart';
import 'package:blogpost/module/post/domain/entity/post.dart';

class PostInteractor {
  final IPostService _postService;

  PostInteractor(this._postService);

  Future<List<Post>> getAllPosts() async {
    try {
      return _postService.getAll();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Post>> getMyPosts() async {
    try {
      return _postService.getMyPosts();
    } catch (e) {
      rethrow;
    }
  }

  Future<Post> getPostDetails(String id) async {
    try {
      return _postService.getPostDetails(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> likePost(String id) async {
    return _postService.likePost(id);
  }

  Future<void> unlikePost(String id) async {
    return _postService.unlikePost(id);
  }

  Future<void> createPost(String title, String content, bool isPublished, File image){
    return _postService.addPost(title, content, isPublished, image);
  }

  Future<void> deletePost(String postId){
    return _postService.deletePost(postId);
  }

  Future<void> updatePost(String postId, String? title, String? content, bool? isPublished, File? image){
    return _postService.updatePost(postId, title, content, isPublished, image);
  }
}