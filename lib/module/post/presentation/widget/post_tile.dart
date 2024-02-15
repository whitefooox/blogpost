import 'package:blogpost/module/post/domain/entity/post.dart';
import 'package:blogpost/module/post/presentation/widget/like_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostTile extends StatelessWidget {

  final Post post;
  final DateFormat formatter = DateFormat('dd.MM.yyyy');

  PostTile({
    super.key, 
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: const BorderRadius.all(Radius.circular(5))
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      //backgroundImage: NetworkImage(post.authorAvatar),
                    ),
                    const SizedBox(width: 10,),
                    Builder(
                      builder: (context){
                        if(post.authorName != null){
                          return Text(post.authorName!);
                        } else {
                          return const Text("No name");
                        }
                      }
                    )
                  ],
                ),
                Text(formatter.format(post.createdAt!))
              ],
            ),
            const SizedBox(height: 10,),
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: 
              Image.network(
                  post.imageUrl,
                  width: double.maxFinite,
                  fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                LikeButton(
                  count: post.likesCount!,
                  isLiked: post.isLiked,
                ),
                const SizedBox(width: 10,),
                Row(
                  children: [
                    const Icon(
                      Icons.mode_comment_outlined,
                      size: 25,
                    ),
                    const SizedBox(width: 5,),
                    Text(
                      post.commentsCount.toString(),
                      style: const TextStyle(
                        fontSize: 20
                      ),
                    )
                  ],
                )
              ],
            )
          ]
        ),
      ),
    );
  }
}