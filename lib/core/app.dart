import 'package:blogpost/core/navigation/app_router.dart';
import 'package:blogpost/feautures/auth/presentation/state/cubit/auth_cubit.dart';
import 'package:blogpost/feautures/entry/presentation/page/create_pincode_page.dart';
import 'package:blogpost/feautures/auth/presentation/page/signin_page.dart';
import 'package:blogpost/feautures/auth/presentation/page/signup_page.dart';
import 'package:blogpost/feautures/post/presentation/page/test_post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit())
      ],
      child: MaterialApp(
        initialRoute: AppRouter.initialRoute,
        routes: AppRouter.routes,
        debugShowCheckedModeBanner: false
      ),
    );
  }
}