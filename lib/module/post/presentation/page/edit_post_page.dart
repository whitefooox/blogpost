import 'dart:io';

import 'package:blogpost/core/enum/loading_status.dart';
import 'package:blogpost/core/widget/bw_button.dart';
import 'package:blogpost/core/widget/bw_input_field.dart';
import 'package:blogpost/module/post/presentation/state/edit/bloc/edit_post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditPostPage extends StatefulWidget {

  const EditPostPage({
    super.key,
  });

  @override
  State<EditPostPage> createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  final _formKey = GlobalKey<FormState>();
  final _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _deletePost() async {
    final bloc = context.read<EditPostBloc>();
    final confirm = await showConfirmDeleteDialog();
    if(confirm != true) return;
    bloc.add(EditPostDeletePostEvent());
    if(mounted) Navigator.maybePop(context);
  }

  Future<bool?> showConfirmDeleteDialog() async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
          title: const Text('Confirmation'),
          content: const Text('Do you want to delete?'),
          actions: <Widget>[
            BwButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .pop(false);
              },
              text: 'No',
            ),
            BwButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .pop(true);
              },
              text: 'Yes',
            ),
          ],
        );
      });
  }

  void _pickImage() async {
    final bloc = context.read<EditPostBloc>();
    final pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    if(pickedImage != null) bloc.add(EditPostUpdateImageEvent(imageUrl: pickedImage.path));
  }

  void _saveChanges() {
    final bloc = context.read<EditPostBloc>();
    if (_formKey.currentState!.validate()) {
      bloc.add(EditPostSaveChangesEvent());
      Navigator.maybePop(context);
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
        "Error loading post",
      ),
    );
  }

  Widget buildEdit(BuildContext context ,EditPostState state){
    final bloc = context.read<EditPostBloc>();

    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(25),
        children: [
          BwInputField(
            labelText: "Title",
            initialValue: state.title,
            onChanged: (value) => bloc.add(EditPostUpdateTitleEvent(title: value)),
          ),
          const SizedBox(height: 20,),
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Builder(
              builder: (context) {
                if (state.newImagePath != null) {
                  return Image.file(
                    File(state.newImagePath!),
                    fit: BoxFit.fill,
                  );
                } else {
                  return Image.network(
                    state.imageUrl,
                    fit: BoxFit.fill,
                  );
                }
              }
            )
          ),
          const SizedBox(height: 20,),
          SizedBox(
            height: 60,
            child: BwButton(
              onPressed: _pickImage, 
              text: "Pick image"
            ),
          ),
          const SizedBox(height: 20,),
          BwInputField(
            initialValue: state.content,
            onChanged: (value) => bloc.add(EditPostUpdateContentEvent(content: value)),
            labelText: "Content", 
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            validator: (value) {
              if(value!.isEmpty){
                return "Empty text";
              } else {
                return null;
              }
            },
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Publish",
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              Switch(
                trackOutlineColor: const MaterialStatePropertyAll(Colors.black),
                activeColor: Colors.black,
                activeTrackColor: Colors.white,
                value: state.isPublish, 
                onChanged: (flag) => bloc.add(EditPostUpdatePublishEvent(isPublish: flag))
              ),
            ],
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    final bloc = context.read<EditPostBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit post"),
        actions: [
          IconButton(
            onPressed: _deletePost, 
            icon: const Icon(Icons.delete)
          ),
          IconButton(
            onPressed: _saveChanges, 
            icon: const Icon(Icons.check)
          )
        ],
      ),
      body: BlocBuilder<EditPostBloc, EditPostState>(
        bloc: bloc,
        builder: ((context, state) {
          if(state.loadingPostStatus == LoadingStatus.loading){
            return buildLoading();
          } else if(state.loadingPostStatus == LoadingStatus.success){
            return buildEdit(context, state);
          } else {
            return buildError();
          }
        })
      ),
    );
  }
}