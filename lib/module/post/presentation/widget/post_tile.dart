import 'package:blogpost/module/post/domain/entity/post.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostTile extends StatelessWidget {

  final Post post;
  final DateFormat formatter = DateFormat('dd.MM.yyyy');

  PostTile({
    super.key, 
    required this.post
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
          //mainAxisAlignment: MainAxisAlignment.start,
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
                    CircleAvatar(
                      backgroundImage: NetworkImage(post.authorAvatar),
                    ),
                    const SizedBox(width: 10,),
                    Text(post.authorName),
                  ],
                ),
                Text(formatter.format(post.date))
              ],
            ),
            const SizedBox(height: 10,),
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.network(
                  post.image,
                  width: double.maxFinite,
                  fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Icon(
                      post.isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                      size: 25,
                    ),
                    const SizedBox(width: 5,),
                    Text(
                      post.likesCount.toString(),
                      style: const TextStyle(
                        fontSize: 20
                      ),
                    )
                  ],
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