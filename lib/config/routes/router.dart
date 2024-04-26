import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:petsguides/core/util/loading_overlay.dart';
import 'package:petsguides/core/util/overlay/generic_overlay.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:petsguides/features/auth/presentation/pages/get_started_view.dart';
import 'package:petsguides/features/auth/presentation/pages/login_view.dart';
import 'package:petsguides/features/auth/presentation/widgets/sign_in_sign_up_overlay.dart';
// import 'package:petsguides/features/auth/presentation/pages/login_view.dart';
import 'package:petsguides/features/shop/presentation/pages/shop_view.dart';
import 'package:petsguides/google_map.dart';

// Function to initialize and configure the GoRouter
GoRouter initRouter(context) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          context.read<AuthBloc>().add(const AuthEventInitialize());
          return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) async {
              if (state is AuthStateFirstLaunch) {
                context.go('/get_started');
              } else if (state is AuthStateLoggedOut) {
                context.go('/home');
              } else if (state is AuthStateLoggedIn) {
                context.go('/home');
              }
            },
            child: Center(
              child: LottieBuilder.asset('assets/splashShiba.json'),
            ),
          );
        },
      ),
      GoRoute(
        path: '/get_started',
        builder: (context, state) => const GetStartedView(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) {
          return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) async {
              final renderBox = context.findRenderObject() as RenderBox;
              final size = renderBox.size;
              // SignInSignUpOverlay as the default widget
              Widget overlay = const SignInSignUpOverlay();
              if (state.isLoading && state is AuthStateLoggedOut) {
                overlay = const SignInSignUpOverlay();
              } else if (!state.isLoading) {
                overlay = LoadingOverlay(size: size);
              }
              GenericOverlay().show(
                context: context,
                builder: (context) => overlay,
              );
            },
            child: const ShopView(),
          );
        },
      ),
      GoRoute(
        path: '/goMap',
        builder: (context, state) => const GoogleMapView(),
      ),
    ],
  );
}
