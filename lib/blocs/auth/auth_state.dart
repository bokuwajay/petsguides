import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthState {
  final bool isLoading;
  const AuthState({
    required this.isLoading,
  });
}

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized({required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;
  const AuthStateRegistering({
    required this.exception,
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class AuthStateLoggedIn extends AuthState {
  const AuthStateLoggedIn({
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class AuthStateLoggedOut extends AuthState {
  final Exception? exception;
  const AuthStateLoggedOut({
    required this.exception,
    required bool isLoading,
  }) : super(isLoading: isLoading);
}
