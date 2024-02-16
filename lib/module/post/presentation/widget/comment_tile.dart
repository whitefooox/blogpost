import 'package:blogpost/module/post/domain/entity/comment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentTile extends StatelessWidget {

  final Comment comment;
  final DateFormat formatter = DateFormat('dd.MM.yyyy');

  CommentTile({
    super.key,
    required this.comment
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${comment.name ?? "<No name>"} ${comment.surname ?? "<No surname>"}"
                ),
                Text(formatter.format(comment.createdAt))
              ],
            ),
            const Divider(),
            Text(
              comment.text,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 14
              ),
            )
          ],
        ),
      ),
    );
  }
}