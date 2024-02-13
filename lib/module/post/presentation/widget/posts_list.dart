import 'package:blogpost/module/post/domain/entity/post.dart';
import 'package:blogpost/module/post/presentation/widget/post_tile.dart';
import 'package:flutter/material.dart';

class PostsList extends StatelessWidget {

  final List<Post> posts;
  void Function(Post post) onTap;

  PostsList({
    super.key,
    required this.posts,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    if(posts.isNotEmpty){
      return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              onTap(posts[index]);
            },
            child: PostTile(post: posts[index])
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 20,
          );
        },
    );
    } else {
      return const Text(
              "No posts"
      );
    }
  }
}