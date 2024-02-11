import 'package:blogpost/module/post/domain/entity/post.dart';
import 'package:flutter/material.dart';

class EditPostPage extends StatelessWidget {

  final Post? post;

  const EditPostPage({
    super.key,
    this.post
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post != null ? post!.title : "New post"),
      ),
    );
  }
}