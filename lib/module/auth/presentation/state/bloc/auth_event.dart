part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthAppLoadedEvent extends AuthEvent {}

class AuthSignInEvent extends AuthEvent {

  final String email;
  final String password;

  AuthSignInEvent({
    required this.email, 
    required this.password
  });
}

class AuthSignUpEvent extends AuthEvent {
  
  final String email;
  final String password;

  AuthSignUpEvent({
    required this.email, 
    required this.password
  });
}

class AuthSignOutEvent extends AuthEvent {

  AuthSignOutEvent();
}
