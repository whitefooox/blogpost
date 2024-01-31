import 'package:blogpost/feautures/auth/presentation/page/signin_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String initialRoute = "/";
  static final routes = {
    "/": (context) => SignInPage(),
  };
}