import 'package:blogpost/feautures/auth/auth_injector.dart';

class AppInjector {
  static void inject(){
    AuthInjector().inject();
  }
}