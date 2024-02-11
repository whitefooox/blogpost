import 'package:blogpost/module/post/domain/entity/post.dart';
import 'package:blogpost/module/post/presentation/widget/post_tile.dart';
import 'package:flutter/material.dart';

class PostsList extends StatelessWidget {

  final List<Post> posts;

  const PostsList({
    super.key,
    required this.posts
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, "/post", arguments: posts[index].id);
            },
            child: PostTile(post: posts[index])
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 20,
          );
        },
      ),
    );
  }
}