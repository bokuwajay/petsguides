import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:petsguides/features/auth/presentation/pages/get_started_view.dart';
import 'package:petsguides/features/auth/presentation/pages/login_view.dart';
import 'package:petsguides/features/market/presentation/pages/market_view.dart';
import 'package:petsguides/google_map.dart';

// Function to initialize and configure the GoRouter
GoRouter initRouter() {
  final authBloc = GetIt.instance.get<AuthBloc>();

  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          authBloc.add(const AuthEventInitialize());
          return Scaffold(
            body: BlocBuilder<AuthBloc, AuthState>(
              bloc: authBloc,
              builder: (context, state) {
                if (state is AuthStateLoggedIn) {
                  // return const SideBar();
                  return const MarketView();
                  // return const LoginSignUpView();
                } else if (state is AuthStateLoggedOut) {
                  return const LoginView();
                  // return const LoginSignUpView();
                  // return const MarketView();
                } else if (state is AuthStateFirstLaunch) {
                  return const GetStartedView();
                  // return const LoginSignUpView();
                  // return const MarketView();
                } else {
                  return Center(
                    child: LottieBuilder.asset('assets/splashShiba.json'),
                  );
                  // return const LoginView();
                }
              },
            ),
          );
        },
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const MarketView(),
      ),
      GoRoute(
        path: '/goMap',
        builder: (context, state) => const GoogleMapView(),
      ),
    ],
  );
}

// Export the initialized router
final GoRouter router = initRouter();
