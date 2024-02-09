import 'package:blogpost/module/auth/presentation/page/signin_page.dart';
import 'package:blogpost/module/auth/presentation/page/signup_page.dart';
import 'package:blogpost/module/auth/presentation/state/bloc/auth_bloc.dart';
import 'package:blogpost/module/entry/presentation/page/create_lock_page.dart';
import 'package:blogpost/module/entry/presentation/page/enter_lock_page.dart';
import 'package:blogpost/module/entry/presentation/state/bloc/app_lock_bloc.dart';
import 'package:blogpost/module/post/presentation/page/blog_post_page.dart';
import 'package:blogpost/module/post/presentation/state/bloc/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AppRouter {
  //final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  final initialRoute = "/";

  final _authBloc = GetIt.instance.get<AuthBloc>()..add(AuthAppLoadedEvent());
  final _lockBloc = GetIt.instance.get<AppLockBloc>()..add(AppLockAppLoadedEvent());

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => Builder(builder: (context) {
            if (_authBloc.state.authGlobalStatus == AuthGlobalStatus.authorized) {
              if(_lockBloc.state.usePin == true){
                return const EnterLockPage();
              } else {
                return const CreateLockPage();
              }
            } else {
              return BlocProvider.value(
                value: _authBloc,
                child: SignInPage(),
              );
            }
          }));
      case "/signin":
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _authBloc, 
            child: SignInPage()
          ),
        );
      case "/signup":
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _authBloc, 
            child: SignUpPage()
          ),
        );
      case "/posts":
      return MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: _authBloc
            ),
            BlocProvider(
              create: (context) => PostsBloc()..add(PostsFetchEvent())
            )
          ],
          child: const BlogPostPage(),
        )
      );
      /*
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _authBloc,
            child: const BlogPostPage(),
        ));
      */
      case "/create_lock":
        return MaterialPageRoute(
          builder: (_) => const CreateLockPage()
        );
      case "/enter_lock":
        return MaterialPageRoute(
          builder: (_) => const EnterLockPage()
        );
      default:
        return null;
    }
  }
}
