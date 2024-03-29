import 'package:blogpost/core/app.dart';
import 'package:blogpost/core/di/locator.dart';
import 'package:blogpost/firebase_options.dart';
import 'package:blogpost/module/notification/data/firebase_notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupLocator();
  await FirebaseNotificationService.init();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]
  );
  runApp(App());
}