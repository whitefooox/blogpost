import 'package:blogpost/core/app.dart';
import 'package:blogpost/core/di/app_injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AppInjector injector = AppInjector();
  await injector.inject();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]
  );
  runApp(const App());
}