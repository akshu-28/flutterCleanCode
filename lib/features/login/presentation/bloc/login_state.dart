part of 'login_bloc.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoggingIn extends LoginState {}

class LoggedInWithSuccess extends LoginState {
  final String message;

  LoggedInWithSuccess({required this.message});
}

class LoggedInWithError extends LoginState {
  final String message;

  LoggedInWithError({required this.message});
}
