import 'package:blogpost/core/widget/bw_button.dart';
import 'package:blogpost/module/auth/presentation/state/bloc/auth_bloc.dart';
import 'package:blogpost/module/entry/presentation/state/bloc/app_lock_bloc.dart';
import 'package:blogpost/module/user/domain/interactor/user_interactor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {

  final UserInteractor userInteractor;

  const SettingsPage({
    super.key,
    required this.userInteractor
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  late AuthBloc authBloc;
  late AppLockBloc lockBloc;

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
    lockBloc = BlocProvider.of<AppLockBloc>(context);
  }

  void goToProfile(){
    Navigator.pushNamed(context, "/profile");
  }

  void logout(){
    authBloc.add(AuthSignOutEvent());
    lockBloc.add(AppLockResetSettingsEvent());
    Navigator.pushReplacementNamed(context, "/");
  }

  void deleteAccount() async {
    await widget.userInteractor.deleteAccount();
    logout();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      backgroundColor: Colors.white,
      body: 
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Center(
              child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 60,
                      child: BwButton(
                          onPressed: goToProfile, 
                          text: "Profile"
                        ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: 60,
                      child: BwButton(
                          onPressed: (){}, 
                          text: "Notifications"
                        ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: 60,
                      child: BwButton(
                          onPressed: deleteAccount,
                          text: "Delete account"
                        ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: 60,
                      child: BwButton(
                          onPressed: logout, 
                          text: "Exit"
                        ),
                    ),
                  ],
                ),
              ),
          ),
    );
  }
}