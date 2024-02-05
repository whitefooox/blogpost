import 'package:blogpost/module/auth/presentation/page/signin_page.dart';
import 'package:blogpost/module/auth/presentation/page/signup_page.dart';
import 'package:blogpost/module/auth/presentation/state/bloc/auth_bloc.dart';
import 'package:blogpost/module/entry/presentation/page/create_lock_page.dart';
import 'package:blogpost/module/post/presentation/page/test_post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  final initialRoute = "/";
  final _authBloc = AuthBloc()..add(AuthAppLoadedEvent());

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _authBloc,
                  child: BlocBuilder<AuthBloc, AuthState>(
                    bloc: _authBloc,
                    builder: (context, state) {
                      if(state.authGlobalStatus == AuthGlobalStatus.authorized){
                        return TestPostPage();
                      } else {
                        return SignInPage();
                      }
                    },
                  ),
                ));
      case "/signin":
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _authBloc,
                  child: BlocListener<AuthBloc, AuthState>(
                    bloc: _authBloc,
                    listener: (context, state) {
                      if(state.authGlobalStatus == AuthGlobalStatus.authorized){
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
                  value: _authBloc,
                  child: BlocListener<AuthBloc, AuthState>(
                    bloc: _authBloc,
                    listener: (context, state) {
                      if(state.authGlobalStatus == AuthGlobalStatus.authorized){
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
                    value: _authBloc,
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
