import 'package:blogpost/module/post/domain/entity/post.dart';
import 'package:blogpost/module/post/domain/interactor/post_interactor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum PostLoadingStatus {
  loading,
  error,
  success
}

class PostPage extends StatefulWidget {
  final String postId;
  final PostInteractor postInteractor;

  const PostPage({
    super.key, 
    required this.postId,
    required this.postInteractor
  });

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  PostLoadingStatus loadingStatus = PostLoadingStatus.loading;
  String? errorMessage;
  Post? post;

  @override
  void setState(VoidCallback fn) {
    if(mounted){
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    () async {
      try {
        post = await widget.postInteractor.getPostDetails(widget.postId);
        setState(() {
          loadingStatus = PostLoadingStatus.success;
        });
      } catch (e) {
        errorMessage = e.toString();
        setState(() {
          loadingStatus = PostLoadingStatus.error;
        });
      }
    }();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void openComments(){
    Navigator.pushNamed(context, "/comments", arguments: widget.postId);
  }

  void likeOrUnlike(){
    if(post!.isLiked){
      setState(() {
        post = post!.copyWith(isLiked: false, likesCount: post!.likesCount - 1);
      });
    } else {
      setState(() {
        post = post!.copyWith(isLiked: true, likesCount: post!.likesCount + 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("View post"),
      ),
      body: Builder(
        builder: (context){
          if(loadingStatus == PostLoadingStatus.loading){
            return const Center(child: CircularProgressIndicator());
          } else if(loadingStatus == PostLoadingStatus.success) {
            return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: deviceSize.width * 0.04, 
                    right: deviceSize.width * 0.04,
                    top: deviceSize.height * 0.01
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.network(
                            post!.image,
                            width: double.maxFinite,
                            fit: BoxFit.fitWidth,
                        ),
                      ),
                      SizedBox(height: deviceSize.height * 0.02,),
                      Text(
                        post!.title,
                        style: const TextStyle(
                          fontSize: 20
                        ),
                      ),
                      SizedBox(height: deviceSize.height * 0.02,),
                      Text(
                        post!.textContent!,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 14
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                        children: [
                          IconButton(
                            onPressed: likeOrUnlike, 
                            icon: Icon(
                              post!.isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                              size: 25,
                            ),
                          ),
                          const SizedBox(width: 5,),
                          Text(
                            post!.likesCount.toString(),
                            style: const TextStyle(
                              fontSize: 20
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.mode_comment_outlined,
                            size: 25,
                          ),
                          const SizedBox(width: 5,),
                          Text(
                            post!.commentsCount.toString(),
                            style: const TextStyle(
                              fontSize: 20
                            ),
                          )
                        ],
                      )
                        ],
                      ),
                      SizedBox(height: deviceSize.height * 0.02,),
                    ],
                  ),
                ),
              );
          } else {
            return const CircularProgressIndicator(); 
          }
        }
      ),
    );
  }
}
