import 'package:blogpost/feautures/auth/presentation/state/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestPostPage extends StatelessWidget {
  const TestPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocBuilder<AuthBloc, AuthState>(
      bloc: authBloc,
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Main page!${state.authGlobalStatus == AuthGlobalStatus.authorized}",
                  style: const TextStyle(fontSize: 20),
                ),
                ElevatedButton(onPressed: () async {
                  authBloc.add(AuthSignOutEvent());
                  Navigator.pushReplacementNamed(context, "/");
                }, child: Text("Exit"))
              ],
            ),
          ),
        );
      },
    );
  }
}
