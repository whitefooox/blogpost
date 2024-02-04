import 'package:blogpost/feautures/auth/presentation/state/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestPostPage extends StatelessWidget {
  const TestPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);

    return BlocBuilder<AuthCubit, AuthState>(
      bloc: authCubit,
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Main page!${authCubit.state.runtimeType}",
                  style: const TextStyle(fontSize: 20),
                ),
                ElevatedButton(onPressed: () async {
                  await authCubit.signOut();
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
