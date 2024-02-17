part of 'auth_bloc.dart';

sealed class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthFailureState extends AuthState {
  final String message;

  AuthFailureState(this.message);
}

class AuthAuthorizedState extends AuthState {}