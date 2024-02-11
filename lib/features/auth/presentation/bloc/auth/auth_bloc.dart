import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:petsguides/core/resources/data_state.dart';
import 'package:petsguides/features/auth/domain/usecases/auth_usecase.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:petsguides/core/util/secure_storage.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase _authUseCase;

  AuthBloc(this._authUseCase)
      : super(const AuthStateUninitialized(isLoading: true)) {
    on<AuthEventInitialize>(
      (event, emit) async {
        try {
          final token = await SecureStorage.readSecureData('pgToken');

          if (token != null) {
            final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

            if (decodedToken['exp'] != null &&
                DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000)
                    .isAfter(DateTime.now())) {
              emit(const AuthStateLoggedIn(isLoading: false));
            } else {
              emit(const AuthStateLoggedOut(exception: null, isLoading: false));
            }
          } else {
            emit(const AuthStateLoggedOut(exception: null, isLoading: false));
          }
        } on DioException catch (exception) {
          emit(AuthStateLoggedOut(exception: exception, isLoading: false));
        }
      },
    );

    on<AuthEventLogIn>((event, emit) async {
      emit(const AuthStateLoggedOut(exception: null, isLoading: true));

      final email = event.email;
      final password = event.password;
      try {
        final dataState =
            await _authUseCase(params: {'email': email, 'password': password});
        if (dataState is DataSuccess && dataState.data!.statusCode == 200) {
          final token = dataState.data!.token!;
          await SecureStorage.writeSecureData('pgToken', token);
          emit(AuthStateLoggedIn(auth: dataState.data, isLoading: false));
        }
        if (dataState is DataFailed) {
          emit(AuthStateLoggedOut(
              exception: dataState.exception, isLoading: false));
        }
      } on DioException catch (exception) {
        emit(
          AuthStateLoggedOut(exception: exception, isLoading: false),
        );
      }
    });
  }
}
