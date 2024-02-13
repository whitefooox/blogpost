import 'dart:developer';

import 'package:blogpost/core/enum/loading_status.dart';
import 'package:blogpost/module/post/domain/entity/comment.dart';
import 'package:blogpost/module/post/domain/interactor/comment_interactor.dart';
import 'package:blogpost/module/post/presentation/widget/comment_tile.dart';
import 'package:flutter/material.dart';

class CommentsPage extends StatefulWidget {
  final bool isAuthorized;
  final String postId;
  final CommentInteractor commentInteractor;

  const CommentsPage({
    super.key,
    required this.isAuthorized,
    required this.postId,
    required this.commentInteractor
  });

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {

  late LoadingStatus loadingStatus;
  List<Comment>? comments;

  void fetchComments() async {
    setState(() {
      loadingStatus = LoadingStatus.loading;
    });
    try {
      comments = await widget.commentInteractor.getComments(widget.postId);
      log("comments page result lenght: ${comments!.length}");
      setState(() {
        loadingStatus = LoadingStatus.success;
      });
    } catch (e) {
      setState(() {
        loadingStatus = LoadingStatus.failure;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: const Text("Comments"),
    ),
    body: Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          Expanded(
            child: _buildCommentList(),
          ),
          if (widget.isAuthorized) _buildCommentForm(),
          ],
        ),
    ),
    );
  }

  Widget _buildCommentList() {
  if (loadingStatus == LoadingStatus.loading) {
    // Отображаем индикатор загрузки
    return const Center(child: CircularProgressIndicator());
  } else if (loadingStatus == LoadingStatus.failure) {
    // Ошибка при загрузке, можно выводить информацию об ошибке
    return const Center(child: Text("Error loading comments"));
  } else if (comments != null) {
    return ListView.separated(
        itemCount: comments!.length,
        itemBuilder: (context, index) {
          final comment = comments![index];
          return CommentTile(comment: comment);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 20,),
    );
  } else {
    // В остальных случаях показываем пустой экран
    return const Center(child: Text("No comments yet"));
  }
}

Widget _buildCommentForm() {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(hintText: 'Add a comment...'),
            // В этом текстовом поле пользователь будет вводить новый комментарий
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: () {
            // Здесь можешь обработать отправку комментария
          },
        ),
      ],
    ),
  );
}
}