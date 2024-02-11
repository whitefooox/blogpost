import 'package:blogpost/module/auth/data/mock_auth_service.dart';
import 'package:blogpost/module/auth/data/token_manager.dart';
import 'package:blogpost/module/auth/domain/dependency/i_auth_service.dart';
import 'package:blogpost/module/auth/domain/dependency/i_token_manager.dart';
import 'package:blogpost/module/auth/domain/interactor/auth_interactor.dart';
import 'package:blogpost/module/auth/presentation/state/bloc/auth_bloc.dart';
import 'package:blogpost/module/entry/data/biometry_service.dart';
import 'package:blogpost/module/entry/data/biometry_storage.dart';
import 'package:blogpost/module/entry/data/pin_storage.dart';
import 'package:blogpost/module/entry/domain/dependency/i_biometry_repository.dart';
import 'package:blogpost/module/entry/domain/dependency/i_biometry_service.dart';
import 'package:blogpost/module/entry/domain/dependency/i_pin_repository.dart';
import 'package:blogpost/module/entry/domain/interactor/lock_interactor.dart';
import 'package:blogpost/module/entry/presentation/state/bloc/app_lock_bloc.dart';
import 'package:blogpost/module/post/data/mock_post_repository.dart';
import 'package:blogpost/module/post/domain/dependency/i_post_repository.dart';
import 'package:blogpost/module/post/domain/interactor/post_interactor.dart';
import 'package:blogpost/module/post/presentation/state/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;
late SharedPreferences sharedPreferences;

Future<void> injectLocalData() async {
  final prefs = await SharedPreferences.getInstance();
  sharedPreferences = getIt.registerSingleton<SharedPreferences>(prefs);
}

void injectAuthModule() {
  final tokenManager = getIt.registerSingleton<ITokenManager>(TokenManager(sharedPreferences));
  final authService = getIt.registerSingleton<IAuthService>(MockAuthService());
  final authInteractor = getIt.registerSingleton<AuthInteractor>(AuthInteractor(tokenManager, authService));
  getIt.registerSingleton<AuthBloc>(AuthBloc());
}

void injectEntryModule(){
  final pinStorage = getIt.registerSingleton<IPinRepository>(PinStorage(sharedPreferences));
  final biometryService = getIt.registerSingleton<IBiometryService>(BiometryService());
  final biometryStorage = getIt.registerSingleton<IBiometryRepository>(BiometryStorage(sharedPreferences));
  final lockInteractor = getIt.registerSingleton<LockInteractor>(LockInteractor(pinStorage, biometryService, biometryStorage));
  getIt.registerSingleton<AppLockBloc>(AppLockBloc());
}

void injectPostsModule(){
  final postsRepository = getIt.registerSingleton<IPostRepository>(MockPostRepository());
  final postsInteractor = getIt.registerSingleton<PostInteractor>(PostInteractor(postsRepository));
  getIt.registerSingleton<PostsBloc>(PostsBloc());
}

Future<void> setupLocator() async {
  await injectLocalData();
  injectAuthModule();
  injectEntryModule();
  injectPostsModule();
}