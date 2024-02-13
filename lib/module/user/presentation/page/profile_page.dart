import 'dart:developer';

import 'package:blogpost/core/enum/loading_status.dart';
import 'package:blogpost/core/widget/bw_button.dart';
import 'package:blogpost/core/widget/bw_input_field.dart';
import 'package:blogpost/core/widget/loading_snackbar.dart';
import 'package:blogpost/module/user/domain/entity/user.dart';
import 'package:blogpost/module/user/domain/interactor/user_interactor.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {

  final UserInteractor userInteractor;

  const ProfilePage({
    super.key,
    required this.userInteractor
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();

  late LoadingStatus loadingStatus;
  User? user;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  void fetchUser() async {
    setState(() {
      loadingStatus = LoadingStatus.loading;
    });
    try {
      user = await widget.userInteractor.getUser();
      if(user!.name != null){
        _nameController.text = user!.name!;
      }
      if(user!.surname != null){
        _surnameController.text = user!.surname!;
      }
      log(user.toString());
      setState(() {
        loadingStatus = LoadingStatus.success;
      });
    } catch (e) {
      log(e.toString());
      setState(() {
        loadingStatus = LoadingStatus.failure;
      });
    }
  }

  void updateUserInfo() async {
    ScaffoldMessenger.of(context).showSnackBar(
      LoadingSnackBars.loadingSnackBar
    );
    try {
      await widget.userInteractor.updateUser(user!.copyWith(
        name: _nameController.text, 
        surname: _surnameController.text
      ));
      ScaffoldMessenger.of(context).showSnackBar(
        LoadingSnackBars.successSnackBar
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        LoadingSnackBars.successSnackBar
      );
    }
    //widget.userInteractor.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile"
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Center(
          child: 
              Builder(
                builder: (context) {
                  if(loadingStatus == LoadingStatus.loading){
                    return const CircularProgressIndicator(color: Colors.black,);
                  } else if(loadingStatus == LoadingStatus.success){
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        Text(
                          user!.email,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20
                          ),
                        ),
                        const SizedBox(height: 20,),
                        BwInputField(
                          labelText: "Name", 
                          textController: _nameController
                        ),
                        const SizedBox(height: 20,),
                        BwInputField(
                          labelText: "Surname", 
                          textController: _surnameController
                        ),
                        const SizedBox(height: 20,),
                        SizedBox(
                          height: 60,
                          child: BwButton(
                            onPressed: updateUserInfo, 
                            text: "Save"
                          ),
                        )
                      ],
                    );
                  } else {
                    return const Text("error");
                  }
                }
              )
        ),
      ),
    );
  }
}