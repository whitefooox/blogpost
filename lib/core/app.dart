import 'package:blogpost/core/navigation/app_router.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {

  final appRouter = AppRouter();
  
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: appRouter.initialRoute,
      onGenerateRoute: appRouter.onGenerateRoute,
      debugShowCheckedModeBanner: false,
      //navigatorKey: appRouter.navigatorKey,
    );
  }
}