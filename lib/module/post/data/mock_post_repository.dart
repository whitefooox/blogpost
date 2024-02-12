import 'dart:developer';

import 'package:blogpost/core/exception/app_exception.dart';
import 'package:blogpost/module/post/domain/dependency/i_post_service.dart';
import 'package:blogpost/module/post/domain/entity/post.dart';

class MockPostRepository implements IPostService {

  List<Post> posts = [
    Post(
      id: '1', 
      title: "First Post", 
      image: "https://imgflip.com/s/meme/Smiling-Cat.jpg", 
      authorId: 1,
      authorName: "cat", 
      authorAvatar: "https://cdn3.iconfinder.com/data/icons/avatars-9/145/Avatar_Cat-512.png", 
      date: DateTime.now(), 
      likesCount: 123, 
      commentsCount: 56,
      isLiked: true,
      textContent: 
      """
      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
      """
    ),

    Post(
      id: '2', 
      title: "Second Post", 
      image: "https://i.imgflip.com/7gll6v.jpg", 
      authorId: 1,
      authorName: "cat", 
      authorAvatar: "https://cdn3.iconfinder.com/data/icons/avatars-9/145/Avatar_Cat-512.png", 
      date: DateTime.now().add(const Duration(days: 2)), 
      likesCount: 75, 
      commentsCount: 5,
      isLiked: false,
      textContent: 
      """
      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
      """
    ),

    Post(
      id: '3', 
      title: "Dog Post", 
      image: "https://i.imgflip.com/7gll6v.jpg", 
      authorId: 2,
      authorName: "dog", 
      authorAvatar: "https://cdn-icons-png.flaticon.com/512/4775/4775486.png", 
      date: DateTime.now().add(const Duration(days: 2)), 
      likesCount: 75, 
      commentsCount: 5,
      isLiked: false,
      textContent: 
      """
      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
      """
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
    await Future.delayed(const Duration(seconds: 3));
    //if(Random().nextInt(10) == 1) throw AppException(message: "Error loading posts"); 
    //throw AppException(message: "Error loading posts");
    //log("complete");
    return posts;
  }

  @override
  Future<Post> getPostDetails(String id) async {
    await Future.delayed(const Duration(seconds: 3));
    for (var post in posts) { 
      if(post.id == id){
        log("${post.title}");
        return post;
      }
    }
    throw AppException(message: "Post not found");
  }
  
  @override
  Future<void> likePost(String id) async {
    for(var i = 0; i < posts.length; i++){
      if(posts[i].id == id && posts[i].isLiked == false){
        posts[i] = posts[i].copyWith(isLiked: true, likesCount: posts[i].likesCount + 1);
      }
    }
  }
  
  @override
  Future<void> unlikePost(String id) async {
    for(var i = 0; i < posts.length; i++){
      if(posts[i].id == id && posts[i].isLiked == true){
        posts[i] = posts[i].copyWith(isLiked: false, likesCount: posts[i].likesCount - 1);
      }
    }
  }
  
  @override
  Future<List<Post>> getMyPosts() async {
    await Future.delayed(const Duration(seconds: 3));
    return posts.where((post){
      if(post.authorId == 1){
        return true;
      } else {
        return false;
      }
    }).toList();
  }
}