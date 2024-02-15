import 'dart:io';

import 'package:blogpost/core/enum/loading_status.dart';
import 'package:blogpost/core/widget/bw_button.dart';
import 'package:blogpost/core/widget/bw_input_field.dart';
import 'package:blogpost/core/widget/loading_snackbar.dart';
import 'package:blogpost/module/post/domain/interactor/post_interactor.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostPage extends StatefulWidget {

  final PostInteractor postInteractor;

  const CreatePostPage({
    super.key,
    required this.postInteractor
  });

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {

  late LoadingStatus loadingStatus;
  final _imagePicker = ImagePicker();
  String? _imagePath;

  final _titleTextController = TextEditingController();
  final _contentTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPublish = false;

  @override
  void initState() {
    super.initState();
  }

  void _pickImage() async {
    final pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imagePath = pickedImage.path;
      });
    }
  }

  void _save() async {
    if(_formKey.currentState!.validate()){
      if(_imagePath != null){
        loadingStatus = LoadingStatus.loading;
        ScaffoldMessenger.of(context).showSnackBar(LoadingSnackBars.loadingSnackBar);
        try {
          await widget.postInteractor.createPost(
            _titleTextController.text, 
            _contentTextController.text, 
            isPublish, 
            File(_imagePath!)
          );
          loadingStatus = LoadingStatus.success;
          if(context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(LoadingSnackBars.successSnackBar);
            Navigator.maybePop(context);
          }
        } catch (e) {
          loadingStatus = LoadingStatus.failure;
          if(context.mounted) ScaffoldMessenger.of(context).showSnackBar(LoadingSnackBars.errorSnackBar("Error"));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create post"),
        actions: [
          IconButton(
            onPressed: _save, 
            icon: const Icon(Icons.check)
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
              //shrinkWrap: true,
              children: [
                BwInputField(
                  labelText: "Title", 
                  textController: _titleTextController,
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Empty title";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20,),
                Builder(
                  builder: (context){
                    if(_imagePath != null){
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Image.file(
                          File(_imagePath!),
                          fit: BoxFit.cover,
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text(
                          "Image not picked",
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                      );
                    }
                  }
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
                  labelText: "Content", 
                  textController: _contentTextController,
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
                      value: isPublish, 
                      onChanged: (flag) {
                        setState(() {
                          isPublish = flag;
                        });
                      }
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
              ],
            ),
      ),
    );
  }
}