import 'package:blogpost/feautures/auth/presentation/page/signin_page.dart';
import 'package:blogpost/feautures/auth/presentation/page/signup_page.dart';
import 'package:blogpost/feautures/post/presentation/page/test_post_page.dart';

class AppRouter {
  static const String initialRoute = "/signin";
  static final routes = {
    "/signin": (context) => SignInPage(),
    "/signup": (context) => SignUpPage(),
    "/posts": (context) => const TestPostPage()
  };
}