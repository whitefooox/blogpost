import 'package:blogpost/core/exception/app_exception.dart';
import 'package:blogpost/module/post/domain/dependency/i_post_repository.dart';
import 'package:blogpost/module/post/domain/entity/post.dart';

class MockPostRepository implements IPostRepository {

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
      isLiked: false
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
        return post;
      }
    }
    throw AppException(message: "Post not found");
  }
}