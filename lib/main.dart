import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:petsguides/features/auth/presentation/pages/login_view.dart';
import 'package:petsguides/injection_container.dart';
import 'package:petsguides/config/themes/themes.dart';
import 'package:petsguides/views/google_map.dart';

void main() async {
  await initializeDependencies();
  runApp(MaterialApp(
    title: 'Flutter Home page',
    theme: ThemeClass.lightTheme,
    darkTheme: ThemeClass.darkTheme,
    themeMode: ThemeMode.system,
    home: BlocProvider<AuthBloc>(
      create: (context) => sl(),
      child: const HomePage(),
    ),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const GoogleMapView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else {
          return const CircularProgressIndicator();
          // return const LoginView();
        }
      },
    );
  }
}
