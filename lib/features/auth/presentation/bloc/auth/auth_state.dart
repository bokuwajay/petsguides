import 'package:equatable/equatable.dart';
import 'package:petsguides/features/auth/domain/entities/auth_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthStateInitial extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateLoginSuccessful extends AuthState {
  final AuthEntity data;

  const AuthStateLoginSuccessful(this.data);

  @override
  List<Object?> get props => [data];
}

class AuthStateLoginFailed extends AuthState {
  final String message;

  const AuthStateLoginFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthStateCheckSignInStatusSuccessful extends AuthState {
  final bool signIn;
  const AuthStateCheckSignInStatusSuccessful(this.signIn);

  @override
  List<Object?> get props => [signIn];
}

class AuthStateCheckSignInStatusFailed extends AuthState {
  final String message;
  const AuthStateCheckSignInStatusFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthStateFirstLaunchSuccessful extends AuthState {
  final bool launchedSuccessful;
  const AuthStateFirstLaunchSuccessful(this.launchedSuccessful);

  @override
  List<Object?> get props => [launchedSuccessful];
}

class AuthStateFirstLaunchFailed extends AuthState {
  final String message;
  const AuthStateFirstLaunchFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthStateCheckFirstLaunchSuccessful extends AuthState {
  final bool isFirstLaunch;
  const AuthStateCheckFirstLaunchSuccessful(this.isFirstLaunch);

  @override
  List<Object?> get props => [isFirstLaunch];
}

class AuthStateCheckFirstLaunchFailed extends AuthState {
  final String message;
  const AuthStateCheckFirstLaunchFailed(this.message);

  @override
  List<Object?> get props => [message];
}
