// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blogpost/module/post/presentation/widget/comment_tile.dart';
import 'package:flutter/material.dart';

import 'package:blogpost/module/post/domain/entity/comment.dart';

class CommentsList extends StatelessWidget {
  final List<Comment> comments;

  const CommentsList({
    Key? key,
    required this.comments,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    if(comments.isNotEmpty) {
      return ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: comments.length,
        itemBuilder: (context, index) {
          return CommentTile(comment: comments[index]);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 20,
          );
        },
      );
    } else {
      return const Center(
        child: Text(
          "No comments"
        ),
      );
    }
  }
}
