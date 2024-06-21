import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:petsguides/config/routes/app_route.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:petsguides/features/auth/presentation/pages/get_started_view.dart';
import 'package:petsguides/features/auth/presentation/pages/login_view.dart';
import 'package:petsguides/features/map/presentation/bloc/map_bloc.dart';
import 'package:petsguides/features/map/presentation/pages/google_map.dart';
import 'package:petsguides/features/shop/presentation/pages/shop_view.dart';
import 'package:petsguides/injection_container.dart';

class AppRouteConfig {
  GoRouter get router => _router;

  late final _router = GoRouter(
    initialLocation: AppRoute.initialScreen.path,
    routes: [
      GoRoute(
        path: AppRoute.initialScreen.path,
        name: AppRoute.initialScreen.name,
        builder: (context, state) {
          context.read<AuthBloc>().add(const AuthEventInitialize());
          return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) async {
              if (state is AuthStateFirstLaunch) {
                router.goNamed(AppRoute.getStarted.name);
              } else if (state is AuthStateLoggedOut) {
                router.goNamed(AppRoute.home.name);
              } else if (state is AuthStateLoggedIn) {
                router.goNamed(AppRoute.map.name);
              }
            },
            child: Center(
              child: LottieBuilder.asset('assets/splashShiba.json'),
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoute.getStarted.path,
        name: AppRoute.getStarted.name,
        builder: (context, state) => const GetStartedView(),
      ),
      GoRoute(
        path: AppRoute.home.path,
        name: AppRoute.home.name,
        builder: (context, state) => const ShopView(),
      ),
      GoRoute(
        path: AppRoute.map.path,
        name: AppRoute.map.name,
        builder: (context, state) {
          return BlocProvider<MapBloc>(
            create: (context) => sl.get<MapBloc>(),
            child: const GoogleMapView(),
          );
        },
      ),
      GoRoute(
        path: AppRoute.login.path,
        name: AppRoute.login.name,
        builder: (context, state) => const LoginView(),
      ),
    ],
  );
}
