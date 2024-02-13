
import 'package:blogpost/core/exception/app_exception.dart';
import 'package:blogpost/module/post/domain/dependency/i_post_service.dart';
import 'package:blogpost/module/post/domain/entity/post.dart';

class MockPostRepository implements IPostService {

  static List<Post> posts = [
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
      isLiked: false,
      textContent: 
      """
      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
      Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
      """
    ),

    Post(
      id: '4', 
      title: "Автоматические двери: История создания. От механики до магнитной левитации", 
      image: "https://habrastorage.org/r/w1560/getpro/habr/upload_files/873/873/45f/87387345f972c0d96b3b8edd5bf2d43f.jpg", 
      authorId: 4, 
      authorName: "Артем", 
      authorAvatar: "https://cdn.iconscout.com/icon/free/png-256/free-avatar-370-456322.png?f=webp", 
      date: DateTime.now(), 
      isLiked: false, 
      likesCount: 1, 
      commentsCount: 1,
      textContent:
      """
      В какой степени прошлое может «объяснить» настоящее, и предсказать будущее? Почему автоматические двери, появившиеся в рекламных каталогах производителей в 1910 году, начали использоваться лишь в конце 20 века. 
      В этой статье мы рассмотрим историческую ретроспективу появления автоматических дверей, попробуем разобраться, почему процесс шел так, а не иначе, и немного поговорим про настоящее и будущее автоматических дверей.
      Первая автоматическая дверь | 1 век н.э.
      Первые «автоматические» двери были изобретены греческим математиком и инженером Героном Александрийским примерно в 60-х годах первого века нашей эры.
      Устройство автоматических дверей описано в трактате «Пневматика», который, по всей вероятности, представляет собой собрание текстов Герона, написанных на греческом языке и собранных в одну книгу после его смерти.
      Самая ранняя сохранившаяся рукописная греческая копия этого текста, датируется 13 веком. Первое печатное латинское издание было опубликовано под названием «Heronis Alexandrini Spiritalium liber» в 1575 году.
      """
    )
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