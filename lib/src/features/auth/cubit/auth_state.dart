part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthLoadedState extends AuthState {
  final User user;

  AuthLoadedState(this.user);
}

final class AuthErrorState extends AuthState {
  final String message;

  AuthErrorState(this.message);
}
