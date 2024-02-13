import 'package:flutter/material.dart';

class EditPostPage extends StatelessWidget {

  final String? postId;

  const EditPostPage({
    super.key,
    this.postId
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(postId != null ? "Edit post" : "Create post"),
      ),
    );
  }
}