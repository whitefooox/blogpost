import 'package:blogpost/module/post/domain/dependency/i_post_repository.dart';
import 'package:blogpost/module/post/domain/entity/post.dart';

class PostInteractor {
  final IPostRepository _postRepository;

  PostInteractor(this._postRepository);

  Future<List<Post>> getAllPosts() async {
    return _postRepository.getAll();
  }
}