import 'package:blogpost/feautures/auth/data/remote_auth_service.dart';
import 'package:blogpost/feautures/auth/data/token_manager.dart';
import 'package:blogpost/feautures/auth/domain/dependency/i_auth_service.dart';
import 'package:blogpost/feautures/auth/domain/dependency/i_token_manager.dart';
import 'package:blogpost/feautures/auth/domain/interactor/auth_interactor.dart';
import 'package:get_it/get_it.dart';

class AuthInjector {
  final getIt = GetIt.instance;

  void inject(){
    final tokenManager = getIt.registerSingleton<ITokenManager>(TokenManager());
    final authService = getIt.registerSingleton<IAuthService>(RemoteAuthService());
    getIt.registerSingleton<AuthInteractor>(AuthInteractor(tokenManager: tokenManager, authService: authService));
  }
}