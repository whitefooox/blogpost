
import 'package:blogpost/module/auth/presentation/page/signin_page.dart';
import 'package:blogpost/module/auth/presentation/page/signup_page.dart';
import 'package:blogpost/module/auth/presentation/state/bloc/auth_bloc.dart';
import 'package:blogpost/module/entry/presentation/page/create_lock_page.dart';
import 'package:blogpost/module/entry/presentation/page/enter_lock_page.dart';
import 'package:blogpost/module/entry/presentation/state/bloc/app_lock_bloc.dart';
import 'package:blogpost/module/post/domain/interactor/post_interactor.dart';
import 'package:blogpost/module/post/presentation/page/blog_post_page.dart';
import 'package:blogpost/module/post/presentation/page/edit_post_page.dart';
import 'package:blogpost/module/post/presentation/page/post_page.dart';
import 'package:blogpost/module/post/presentation/state/posts/posts_bloc.dart';
import 'package:blogpost/module/settings/presentation/page/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AppRouter {
  //final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  final initialRoute = "/";

  final _postInteractor = GetIt.instance.get<PostInteractor>();

  final _authBloc = GetIt.instance.get<AuthBloc>()..add(AuthAppLoadedEvent());
  final _lockBloc = GetIt.instance.get<AppLockBloc>()
    ..add(AppLockAppLoadedEvent());

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => Builder(builder: (context) {
                  if (_authBloc.state is AuthAuthorizedState) {
                    if (_lockBloc.state.usePin == true) {
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
          builder: (_) =>
              BlocProvider.value(value: _authBloc, child: SignInPage()),
        );
      case "/signup":
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider.value(value: _authBloc, child: SignUpPage()),
        );
      case "/posts":
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: _authBloc),
                    BlocProvider(
                        create: (context) =>
                            PostsBloc()..add(PostsFetchEvent()))
                  ],
                  child: const BlogPostPage(),
                ));
      case "/create_lock":
        return MaterialPageRoute(builder: (_) => const CreateLockPage());
      case "/enter_lock":
        return MaterialPageRoute(builder: (_) => const EnterLockPage());
      case "/settings":
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: _authBloc),
                    BlocProvider.value(value: _lockBloc),
                  ],
                  child: const SettingsPage(),
                ));
      case "/edit_post":
        return MaterialPageRoute(builder: (_) => const EditPostPage());
      case "/post":
        {
          final postId = settings.arguments;
          if (postId is String) {
            return MaterialPageRoute(
              builder: (_) => PostPage(postId: postId, postInteractor: _postInteractor,),
              );
          } else {
            return null;
          }
        }
      default:
        return null;
    }
  }
}
