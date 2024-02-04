import 'package:blogpost/feautures/auth/presentation/page/signin_page.dart';
import 'package:blogpost/feautures/auth/presentation/page/signup_page.dart';
import 'package:blogpost/feautures/auth/presentation/state/cubit/auth_cubit.dart';
import 'package:blogpost/feautures/entry/presentation/page/create_lock_page.dart';
import 'package:blogpost/feautures/post/presentation/page/test_post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static const initialRoute = "/entry";
  static final _authCubit = AuthCubit();

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _authCubit,
                  child: BlocListener<AuthCubit, AuthState>(
                    bloc: _authCubit,
                    listener: (context, state) {
                      if(state is AuthAuthenticated){
                        Navigator.pushReplacementNamed(context, "/posts");
                      }
                    },
                    child: SignInPage(),
                  ),
                ));
      case "/signin":
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _authCubit,
                  child: BlocListener<AuthCubit, AuthState>(
                    bloc: _authCubit,
                    listener: (context, state) {
                      if(state is AuthAuthenticated){
                        Navigator.pushReplacementNamed(context, "/posts");
                      }
                    },
                    child: SignInPage(),
                  ),
                ));
      case "/signup":
        {
          return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _authCubit,
                  child: BlocListener<AuthCubit, AuthState>(
                    bloc: _authCubit,
                    listener: (context, state) {
                      if(state is AuthAuthenticated){
                        Navigator.pushReplacementNamed(context, "/posts");
                      }
                    },
                    child: SignUpPage(),
                  ),
                ));
        }
      case "/posts":
        {
          return MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                    value: _authCubit,
                    child: const TestPostPage(),
                  ));
        }
      case "/entry":
      {
        return MaterialPageRoute(
          builder: (_) => CreateLockPage()
        );
      }
      default:
        return null;
    }
  }
}
