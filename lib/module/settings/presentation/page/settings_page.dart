import 'package:blogpost/core/widget/bw_button.dart';
import 'package:blogpost/module/auth/presentation/state/bloc/auth_bloc.dart';
import 'package:blogpost/module/entry/presentation/state/bloc/app_lock_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final lockBloc = BlocProvider.of<AppLockBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      backgroundColor: Colors.white,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: deviceSize.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: deviceSize.height * 0.5 * 0.15,
                    width: deviceSize.width / 2,
                    child: BwButton(
                      onPressed: (){}, 
                      text: "Profile"
                    ),
                  ),
                  SizedBox(
                    height: deviceSize.height * 0.5 * 0.15,
                    width: deviceSize.width / 2,
                    child: BwButton(
                      onPressed: (){}, 
                      text: "Notifications"
                    ),
                  ),
                  SizedBox(
                    height: deviceSize.height * 0.5 * 0.15,
                    width: deviceSize.width / 2,
                    child: BwButton(
                      onPressed: (){}, 
                      text: "Delete account"
                    ),
                  ),
                  SizedBox(
                    height: deviceSize.height * 0.5 * 0.15,
                    width: deviceSize.width / 2,
                    child: BwButton(
                      onPressed: (){
                        lockBloc.add(AppLockResetSettingsEvent());
                        authBloc.add(AuthSignOutEvent());
                        Navigator.pushReplacementNamed(context, "/");
                      }, 
                      text: "Exit"
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
}