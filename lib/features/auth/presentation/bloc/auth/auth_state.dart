import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:petsguides/features/auth/domain/entities/auth_entity.dart';

abstract class AuthState extends Equatable {
  final AuthEntity? auth;
  final DioException? dioException;
  final Exception? genericException;
  final bool isLoading;
  const AuthState({
    this.auth,
    this.dioException,
    this.genericException,
    required this.isLoading,
  });

  @override
  List<Object?> get props => [auth, dioException, genericException, isLoading];
}

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized({required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStateLoggedIn extends AuthState {
  final AuthEntity? auth;
  const AuthStateLoggedIn({
    this.auth,
    required bool isLoading,
  }) : super(auth: auth, isLoading: isLoading);
}

class AuthStateLoggedOut extends AuthState {
  final DioException? dioException;
  final Exception? genericException;
  const AuthStateLoggedOut({
    this.dioException,
    this.genericException,
    required bool isLoading,
  }) : super(
          dioException: dioException,
          genericException: genericException,
          isLoading: isLoading,
        );
}
