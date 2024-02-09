import 'dart:developer';

import 'package:blogpost/module/post/domain/dependency/i_post_repository.dart';
import 'package:blogpost/module/post/domain/entity/post.dart';

class MockPostRepository implements IPostRepository {

  List<Post> posts = [
    Post(
      id: 1, 
      title: "First Post", 
      image: "https://imgflip.com/s/meme/Smiling-Cat.jpg", 
      authorName: "cat", 
      authorAvatar: "https://cdn3.iconfinder.com/data/icons/avatars-9/145/Avatar_Cat-512.png", 
      date: DateTime.now(), 
      likesCount: 123, 
      commentsCount: 56
    ),

    Post(
      id: 2, 
      title: "Second Post", 
      image: "https://i.imgflip.com/7gll6v.jpg", 
      authorName: "cat", 
      authorAvatar: "https://cdn3.iconfinder.com/data/icons/avatars-9/145/Avatar_Cat-512.png", 
      date: DateTime.now().add(const Duration(days: 2)), 
      likesCount: 75, 
      commentsCount: 5
    ),
  ];

  @override
  Future<void> addPost(Post post) {
    // TODO: implement addPost
    throw UnimplementedError();
  }

  @override
  Future<void> deletePost(int id) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<void> editPost(Post post) {
    // TODO: implement editPost
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> getAll() async {
    await Future.delayed(Duration(seconds: 3));
    log("complete");
    return posts;
  }

  @override
  Future<Post> getPostDetails(int id) {
    // TODO: implement getPostDetails
    throw UnimplementedError();
  }
}