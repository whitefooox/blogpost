import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:blogpost/feautures/auth/domain/interactor/auth_interactor.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {

  final authInteractor = GetIt.instance.get<AuthInteractor>();

  AuthCubit() : super(AuthInitial()){
    _init();
  }

  void _init() async {
    //Future.delayed(Duration(seconds: 3));
    emit(await authInteractor.checkAuthorization() ? AuthAuthenticated() : AuthInitial());
  }

  void signIn(String email, String password) async {
    emit(AuthLoading());
    log("cubit:" + state.runtimeType.toString());
    try {
      bool isAuthenticated = await authInteractor.signIn(email, password);
      if(isAuthenticated){
        emit(AuthAuthenticated());
        log("cubit:" + state.runtimeType.toString());
      } else {
        emit(AuthUnauthenticated());
        log("cubit:" + state.runtimeType.toString());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
      log("cubit:" + state.runtimeType.toString());
    }
  }

  void signUp(String email, String password) async {
    emit(AuthLoading());
    try {
      bool isAuthenticated = await authInteractor.signUp(email, password);
      if(isAuthenticated){
        emit(AuthAuthenticated());
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
