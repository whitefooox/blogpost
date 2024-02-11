import 'package:bloc/bloc.dart';
import 'package:blogpost/module/auth/domain/interactor/auth_interactor.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final authInteractor = GetIt.instance.get<AuthInteractor>();

  AuthBloc() : super(AuthInitialState()) {

    on<AuthAppLoadedEvent>(_appLoaded);
    on<AuthSignInEvent>(_signIn);
    on<AuthSignUpEvent>(_signUp);
    on<AuthSignOutEvent>(_signOut);
  }

  void _appLoaded(
    AuthAppLoadedEvent event, 
    Emitter<AuthState> emit
  ){
    final isAuthorized = authInteractor.checkAuthorization();
    if(isAuthorized){
      emit(AuthAuthorizedState());
    }
    //emit(state.copyWith(authGlobalStatus: isAuthorized ? AuthGlobalStatus.authorized : AuthGlobalStatus.unauthorized));
  }

  void _signIn(
    AuthSignInEvent event,
    Emitter<AuthState> emit
  ) async {
    //emit(state.copyWith(authProcessStatus: AuthProcessStatus.loading));
    emit(AuthLoadingState());
    try {
      bool isAuthenticated = await authInteractor.signIn(event.email, event.password);
      if(isAuthenticated){
        //emit(state.copyWith(authProcessStatus: AuthProcessStatus.authorized, authGlobalStatus: AuthGlobalStatus.authorized));
        emit(AuthAuthorizedState());
      } else {
        //emit(state.copyWith(authProcessStatus: AuthProcessStatus.unauthorized));
        emit(AuthUnauthorizedState());
      }
    } catch (e) {
      //emit(state.copyWith(authProcessStatus: AuthProcessStatus.failure, errorMessage: e.toString()));
      emit(AuthFailureState(e.toString()));
    }
  }

  void _signUp(
    AuthSignUpEvent event,
    Emitter<AuthState> emit
  ) async {
    //emit(state.copyWith(authProcessStatus: AuthProcessStatus.loading));
    emit(AuthLoadingState());
    try {
      bool isAuthenticated = await authInteractor.signUp(event.email, event.password);
      if(isAuthenticated){
        //emit(state.copyWith(authProcessStatus: AuthProcessStatus.authorized, authGlobalStatus: AuthGlobalStatus.authorized));
        emit(AuthAuthorizedState());
      } else {
        //emit(state.copyWith(authProcessStatus: AuthProcessStatus.unauthorized));
        emit(AuthUnauthorizedState());
      }
    } catch (e) {
      emit(AuthFailureState(e.toString()));
      //emit(state.copyWith(authProcessStatus: AuthProcessStatus.failure, errorMessage: e.toString()));
    }
  }

  void _signOut(
    AuthSignOutEvent event,
    Emitter<AuthState> emit
  ) async {
    await authInteractor.signOut();
    emit(AuthInitialState());
    //emit(state.copyWith(authGlobalStatus: AuthGlobalStatus.unauthorized, authProcessStatus: AuthProcessStatus.initial));
  }
}
