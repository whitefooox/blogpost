part of 'auth_bloc.dart';

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
