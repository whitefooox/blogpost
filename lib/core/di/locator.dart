import 'package:blogpost/module/auth/data/firebase_auth_service.dart';
import 'package:blogpost/module/auth/domain/dependency/i_auth_service.dart';
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
import 'package:blogpost/module/notification/data/firebase_notification_service.dart';
import 'package:blogpost/module/notification/data/notification_storage.dart';
import 'package:blogpost/module/notification/domain/dependency/i_notification_service.dart';
import 'package:blogpost/module/notification/domain/dependency/i_notification_storage.dart';
import 'package:blogpost/module/notification/domain/interactor/notification_interactor.dart';
import 'package:blogpost/module/post/data/firebase_comment_service.dart';
import 'package:blogpost/module/post/data/firebase_post_service.dart';
import 'package:blogpost/module/post/domain/dependency/i_comment_service.dart';
import 'package:blogpost/module/post/domain/dependency/i_post_service.dart';
import 'package:blogpost/module/post/domain/interactor/comment_interactor.dart';
import 'package:blogpost/module/post/domain/interactor/post_interactor.dart';
import 'package:blogpost/module/user/data/firebase_user_service.dart';
import 'package:blogpost/module/user/domain/dependency/i_user_service.dart';
import 'package:blogpost/module/user/domain/interactor/user_interactor.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;
late SharedPreferences sharedPreferences;

Future<void> injectLocalData() async {
  final prefs = await SharedPreferences.getInstance();
  sharedPreferences = getIt.registerSingleton<SharedPreferences>(prefs);
}

void injectAuthModule() {
  final userService = getIt.registerSingleton<IUserService>(FirebaseUserService());
  final userInteractor = getIt.registerSingleton<UserInteractor>(UserInteractor(userService));
  final authService = getIt.registerSingleton<IAuthService>(FirebaseAuthService(userService));
  final authInteractor = getIt.registerSingleton<AuthInteractor>(AuthInteractor(authService));
  getIt.registerSingleton<AuthBloc>(AuthBloc());
}

void injectEntryModule(){
  final pinStorage = getIt.registerSingleton<IPinRepository>(PinStorage(sharedPreferences));
  final biometryService = getIt.registerSingleton<IBiometryService>(BiometryService());
  final biometryStorage = getIt.registerSingleton<IBiometryRepository>(BiometryStorage(sharedPreferences));
  final lockInteractor = getIt.registerSingleton<LockInteractor>(LockInteractor(
    pinStorage, 
    biometryService, 
    biometryStorage));
  getIt.registerSingleton<AppLockBloc>(AppLockBloc());
}

void injectPostsModule(){
  final postsRepository = getIt.registerSingleton<IPostService>(FirebasePostService());
  final postsInteractor = getIt.registerSingleton<PostInteractor>(PostInteractor(postsRepository));

  final commentService = getIt.registerSingleton<ICommentService>(FirebaseCommentService());
  final commentInteractor = getIt.registerSingleton<CommentInteractor>(CommentInteractor(commentService));
}

void injectNotificationModule(){
  final notificationService = getIt.registerSingleton<INotificationService>(FirebaseNotificationService());
  final notificationStorage = getIt.registerSingleton<INotificationStorage>(NotificationStorage(sharedPreferences));
  final notificationInteractor = getIt.registerSingleton<NotificationInteractor>(NotificationInteractor(notificationService, notificationStorage));
}

Future<void> setupLocator() async {
  await injectLocalData();
  injectAuthModule();
  injectEntryModule();
  injectPostsModule();
  injectNotificationModule();
}