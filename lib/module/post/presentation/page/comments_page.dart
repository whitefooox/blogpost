import 'package:blogpost/core/enum/loading_status.dart';
import 'package:blogpost/core/widget/loading_snackbar.dart';
import 'package:blogpost/module/auth/presentation/state/bloc/auth_bloc.dart';
import 'package:blogpost/module/post/presentation/state/comment/bloc/comments_bloc.dart';
import 'package:blogpost/module/post/presentation/widget/comments_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsPage extends StatelessWidget {

  final _commentController = TextEditingController();

  CommentsPage({
    super.key,
  });

  void _sendComment(BuildContext context){
    final commentBloc = BlocProvider.of<CommentsBloc>(context);
    if(_commentController.text.isNotEmpty){
      commentBloc.add(CommentsAddCommentEvent(comment: _commentController.text));
    }
  }

  Widget buildLoading(){
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.black,
      ),
    );
  }

  Widget buildError(){
    return const Center(
      child: Text(
        "Error loading comments",
      ),
    );
  }

  Widget buildSendField(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: const BorderRadius.all(Radius.circular(5))
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _commentController,
                decoration: null,
              ),
            )
          ),
          BlocBuilder<CommentsBloc, CommentsState>(
            builder: (context, state){
              if(state.addCommentStatus == LoadingStatus.loading){
                return const SizedBox(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                );
              } else {
                return IconButton(
                  onPressed: () => _sendComment(context), 
                  icon: const Icon(
                    Icons.send
                  )
                );
              }
            }
          )
          
        ],
      ),
    );
  }

  Widget buildComments(BuildContext context, CommentsState state){
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: CommentsList(comments: state.comments)
          ),
          const SizedBox(height: 20,),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              if(authState is AuthAuthorizedState){
                return buildSendField(context);
              } else {
                return Container();
              }
            }
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: const Text("Comments"),
    ),
    body: BlocListener<CommentsBloc, CommentsState>(
      listener: (context, state) {
        if(state.addCommentStatus == LoadingStatus.failure){
          ScaffoldMessenger.of(context).showSnackBar(LoadingSnackBars.errorSnackBar("Error add comment"));
        } else if(state.addCommentStatus == LoadingStatus.success){
          _commentController.clear();
        }
      },
      child: BlocBuilder<CommentsBloc, CommentsState>(
        builder: ((context, state) {
          if(state.loadingStatus == LoadingStatus.loading && state.comments.isEmpty){
            return buildLoading();
          } else if(state.loadingStatus == LoadingStatus.success){
            return buildComments(context, state);
          } else {
            return buildError();
          }
        })
      ),
    )
    );
  }
}