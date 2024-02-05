import 'package:blogpost/feautures/auth/data/mock_auth_service.dart';
import 'package:blogpost/feautures/auth/data/token_manager.dart';
import 'package:blogpost/feautures/auth/domain/dependency/i_auth_service.dart';
import 'package:blogpost/feautures/auth/domain/dependency/i_token_manager.dart';
import 'package:blogpost/feautures/auth/domain/interactor/auth_interactor.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInjector {
  final getIt = GetIt.instance;
  late SharedPreferences sharedPreferences;

  Future<void> injectLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    sharedPreferences = getIt.registerSingleton<SharedPreferences>(prefs);
  }

  void injectAuthModule() {
    final tokenManager = getIt.registerSingleton<ITokenManager>(TokenManager(prefs: sharedPreferences));
    final authService = getIt.registerSingleton<IAuthService>(MockAuthService());
    getIt.registerSingleton<AuthInteractor>(AuthInteractor(tokenManager: tokenManager, authService: authService));
  }

  Future<void> inject() async {
    await injectLocalData();
    injectAuthModule();
  }
}