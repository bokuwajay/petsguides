import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsguides/core/usecases/usecase.dart';
import 'package:petsguides/core/util/failure_converter.dart';
import 'package:petsguides/core/util/logger.dart';
import 'package:petsguides/features/auth/domain/usecases/auth_check_first_launch_usecase.dart';
import 'package:petsguides/features/auth/domain/usecases/auth_check_signin_status_usecase.dart';
import 'package:petsguides/features/auth/domain/usecases/auth_first_launch_usecase.dart';
import 'package:petsguides/features/auth/domain/usecases/auth_usecase.dart';
import 'package:petsguides/features/auth/domain/usecases/usecase_params.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase _authUseCase;
  final AuthCheckSignInStatusUseCase _authCheckSignInStatusUseCase;
  final AuthFirstLaunchUseCase _authFirstLaunchUseCase;
  final AuthCheckFirstLaunchUseCase _authCheckFirstLaunchUseCase;

  AuthBloc(this._authUseCase, this._authCheckSignInStatusUseCase,
      this._authFirstLaunchUseCase, this._authCheckFirstLaunchUseCase)
      : super(AuthStateInitial()) {
    // login
    on<AuthEventLogIn>((event, emit) async {
      emit(AuthStateLoading());
      final result = await _authUseCase
          .call(LoginParams(email: event.email, password: event.password));
      result.fold(
        (l) => emit(AuthStateLoginFailed(failureConverter(l))),
        (r) => emit(AuthStateLoginSuccessful(r)),
      );
    });
    // check login status
    on<AuthEventCheckSignInStatus>(
      (event, emit) async {
        emit(AuthStateLoading());
        final result = await _authCheckSignInStatusUseCase.call(NoParams());
        result.fold(
            (l) => emit(AuthStateCheckSignInStatusFailed(failureConverter(l))),
            (r) => emit(AuthStateCheckSignInStatusSuccessful(r)));
      },
    );
    // first time launch
    on<AuthEventFirstLaunch>(
      (event, emit) async {
        emit(AuthStateLoading());
        final result = await _authFirstLaunchUseCase.call(NoParams());
        result.fold(
            (l) => emit(AuthStateFirstLaunchFailed(failureConverter(l))),
            (r) => emit(AuthStateFirstLaunchSuccessful()));
      },
    );

// check if first time launch
    on<AuthEventCheckFirstLaunch>(
      (event, emit) async {
        emit(AuthStateLoading());
        final result = await _authCheckFirstLaunchUseCase.call(NoParams());
        result.fold(
            (l) => emit(AuthStateCheckFirstLaunchFailed(failureConverter(l))),
            (r) => emit(AuthStateCheckFirstLaunchSuccessful(r)));
      },
    );
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE AuthBloc =====");
    return super.close();
  }
}
