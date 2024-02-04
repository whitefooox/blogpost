import 'package:bloc/bloc.dart';
import 'package:blogpost/feautures/auth/domain/interactor/auth_interactor.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {

  final authInteractor = GetIt.instance.get<AuthInteractor>();

  AuthCubit() : super(AuthInitial()){
    checkAuthorization();
  }

  void checkAuthorization() async {
    emit(await authInteractor.checkAuthorization() ? AuthAuthenticated() : AuthInitial());
  }

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      bool isAuthenticated = await authInteractor.signIn(email, password);
      if(isAuthenticated){
        emit(AuthAuthenticated());
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> signUp(String email, String password) async {
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

  Future<void> signOut() async {
    await authInteractor.signOut();
    emit(AuthAuthenticated());
  }
}
