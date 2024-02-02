import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsguides/blocs/auth/auth_bloc.dart';
import 'package:petsguides/blocs/auth/auth_event.dart';
import 'package:petsguides/blocs/auth/auth_state.dart';
import 'package:petsguides/services/auth/auth_service.dart';
import 'package:petsguides/services/dio/dio_interceptor.dart';
import 'package:petsguides/themes/themes.dart';
import 'package:petsguides/views/google_map.dart';
import 'package:petsguides/views/loading/loading_screen.dart';
import 'package:petsguides/views/login_view.dart';
// import 'dart:developer' as devtools show log;

// void main() {
//   runApp(MaterialApp.router(
//     routerConfig: router,
//   ));
// }

void main() {
  runApp(MaterialApp(
    title: 'Flutter Home page',
    theme: ThemeClass.lightTheme,
    darkTheme: ThemeClass.darkTheme,
    themeMode: ThemeMode.system,
    home: BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(AuthService(HttpUtil())),
      child: const HomePage(),
    ),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(context: context);
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const GoogleMapView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else {
          // return const Scaffold(
          //   body: Center(
          //     child: CircularProgressIndicator(),
          //   ),
          // );
          return const LoginView();
        }
      },
    );
  }
}
