// import 'package:bloc/bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:petsguides/blocs/auth/auth_event.dart';
// import 'package:petsguides/blocs/auth/auth_state.dart';
// import 'package:petsguides/core/util/secure_storage.dart';
// import 'package:petsguides/services/auth/auth_service.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthService authService;

//   AuthBloc(this.authService)
//       : super(const AuthStateUninitialized(isLoading: true)) {
//     on<AuthEventInitialize>(
//       (event, emit) async {
//         try {
//           final token = await SecureStorage.readSecureData('pgToken');
//           if (token != null) {
//             final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

//             if (decodedToken['exp'] != null &&
//                 DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000)
//                     .isAfter(DateTime.now())) {
//               emit(const AuthStateLoggedIn(isLoading: false));
//             } else {
//               emit(const AuthStateLoggedOut(exception: null, isLoading: false));
//             }
//           } else {
//             emit(const AuthStateLoggedOut(exception: null, isLoading: false));
//           }
//         } on Exception catch (exception) {
//           emit(AuthStateLoggedOut(exception: exception, isLoading: false));
//         }
//       },
//     );

//     on<AuthEventRegister>(
//       (event, emit) async {
//         final firstName = event.firstName;
//         final lastName = event.lastName;
//         final email = event.email;
//         final password = event.password;
//         final phone = event.phone;

//         try {
//           await authService.register(
//               firstName, lastName, email, password, phone);
//         } on Exception catch (exception) {
//           emit(AuthStateRegistering(
//             exception: exception,
//             isLoading: false,
//           ));
//         }
//       },
//     );

//     on<AuthEventLogIn>(
//       (event, emit) async {
//         emit(const AuthStateLoggedOut(exception: null, isLoading: true));

//         final email = event.email;
//         final password = event.password;

//         try {
//           final response = await authService.authenticate(email, password);

//           if (response != null && response['statusCode'] == 200) {
//             final token = response['data']['token'];
//             await SecureStorage.writeSecureData('pgToken', token);

//             emit(const AuthStateLoggedOut(exception: null, isLoading: false));

//             emit(const AuthStateLoggedIn(isLoading: false));
//           } else {
//             emit(const AuthStateLoggedOut(exception: null, isLoading: false));
//           }
//         } on Exception catch (exception) {
//           emit(AuthStateLoggedOut(exception: exception, isLoading: false));
//         }
//       },
//     );
//   }
// }
