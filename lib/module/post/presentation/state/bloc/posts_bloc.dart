import 'package:bloc/bloc.dart';
import 'package:blogpost/module/post/domain/entity/post.dart';
import 'package:blogpost/module/post/domain/interactor/post_interactor.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {

  final postInteractor = GetIt.instance.get<PostInteractor>();

  PostsBloc() : super(PostsInitial()) {
    on<PostsFetchEvent>(_fetchPosts);
  }

  void _fetchPosts(
    PostsFetchEvent event,
    Emitter<PostsState> emit
  ) async {
    emit(PostsLoading());
    try {
      final posts = await postInteractor.getAllPosts();
      posts.sort((a, b) => b.date.compareTo(a.date));
      emit(PostsLoaded(posts));
    } catch (e) {
      emit(PostsError("error in posts"));
    }
    /*
    postInteractor.getAllPosts().then((posts) async {
      emit(PostsLoaded(posts));
    });
    */
    //.catchError((error){
      //emit(PostsError("error in posts"));
    //});
  }
}
