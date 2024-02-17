
import 'package:blogpost/core/enum/loading_status.dart';
import 'package:blogpost/module/post/domain/entity/post.dart';
import 'package:blogpost/module/post/domain/interactor/post_interactor.dart';
import 'package:blogpost/module/post/presentation/widget/like_button.dart';
import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  final String postId;
  final PostInteractor postInteractor;

  const PostPage({
    super.key, 
    required this.postId,
    required this.postInteractor,
  });

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  LoadingStatus loadingStatus = LoadingStatus.loading;
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
          loadingStatus = LoadingStatus.success;
        });
      } catch (e) {
        errorMessage = e.toString();
        setState(() {
          loadingStatus = LoadingStatus.failure;
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
    if(post!.isLiked!){
      setState(() {
        post = post!.copyWith(isLiked: false, likesCount: post!.likesCount! - 1);
        widget.postInteractor.unlikePost(widget.postId);
      });
    } else {
      setState(() {
        post = post!.copyWith(isLiked: true, likesCount: post!.likesCount! + 1);
        widget.postInteractor.likePost(widget.postId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View post"),
      ),
      body: Builder(
        builder: (context){
          if(loadingStatus == LoadingStatus.loading){
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              )
            );
          } else if(loadingStatus == LoadingStatus.success) {
            return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 25, 
                    right: 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.network(
                            post!.imageUrl,
                            width: double.maxFinite,
                            fit: BoxFit.fitWidth,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        post!.title,
                        style: const TextStyle(
                          fontSize: 20
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        post!.content!,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 14
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                      LikeButton(
                        count: post!.likesCount!,
                        isLiked: post!.isLiked,
                        onTap: likeOrUnlike,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: openComments, 
                            icon: const Icon(
                              Icons.mode_comment_outlined,
                              size: 25,
                            ),
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
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
          } else {
            return const Text("Error loading post");
          }
        }
      ),
    );
  }
}
