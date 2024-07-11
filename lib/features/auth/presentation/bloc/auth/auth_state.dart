import 'package:equatable/equatable.dart';
import 'package:petsguides/features/auth/domain/entities/auth_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthStateInitial extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateFailed extends AuthState {
  final String message;

  const AuthStateFailed(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthStateLoginSuccessful extends AuthState {
  final AuthEntity data;

  const AuthStateLoginSuccessful(this.data);

  @override
  List<Object?> get props => [data];
}

class AuthStateCheckSignInStatusSuccessful extends AuthState {
  final bool signIn;
  const AuthStateCheckSignInStatusSuccessful(this.signIn);

  @override
  List<Object?> get props => [signIn];
}

class AuthStateFirstLaunchSuccessful extends AuthState {
  final bool launchedSuccessful;
  const AuthStateFirstLaunchSuccessful(this.launchedSuccessful);

  @override
  List<Object?> get props => [launchedSuccessful];
}

class AuthStateCheckFirstLaunchSuccessful extends AuthState {
  final bool isFirstLaunch;
  const AuthStateCheckFirstLaunchSuccessful(this.isFirstLaunch);

  @override
  List<Object?> get props => [isFirstLaunch];
}
