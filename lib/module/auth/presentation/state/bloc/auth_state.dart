part of 'auth_bloc.dart';

sealed class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthFailureState extends AuthState {
  final String message;

  AuthFailureState(this.message);
}

class AuthAuthorizedState extends AuthState {}

class AuthUnauthorizedState extends AuthState {}

/*

enum AuthGlobalStatus {
  unauthorized,
  authorized,
}

enum AuthProcessStatus {
  initial,
  loading,
  failure,
  authorized,
  unauthorized
}

class AuthState {
  final AuthGlobalStatus authGlobalStatus;
  final AuthProcessStatus? authProcessStatus;
  final String? errorMessage;
  
  AuthState({
    this.authGlobalStatus = AuthGlobalStatus.unauthorized,
    this.authProcessStatus = AuthProcessStatus.initial,
    this.errorMessage
  });

  AuthState copyWith({
    AuthGlobalStatus? authGlobalStatus,
    AuthProcessStatus? authProcessStatus,
    String? errorMessage
  }) { 
    return AuthState(
      authGlobalStatus: authGlobalStatus ?? this.authGlobalStatus,
      authProcessStatus: authProcessStatus ?? this.authProcessStatus,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
}
*/
