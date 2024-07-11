import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:petsguides/config/routes/app_route.dart';
import 'package:petsguides/config/routes/app_route_config.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:petsguides/injection_container.dart';

class InitialView extends StatefulWidget {
  const InitialView({super.key});

  @override
  State<InitialView> createState() => _InitialViewState();
}

class _InitialViewState extends State<InitialView> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const AuthEventCheckSignInStatus());
  }

  @override
  Widget build(BuildContext context) {
    final router = sl.get<AppRouteConfig>().router;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateCheckSignInStatusSuccessful) {
          if (state.signIn) {
            router.goNamed(AppRoute.map.name);
          } else {
            context.read<AuthBloc>().add(const AuthEventCheckFirstLaunch());
          }
        } else if (state is AuthStateCheckFirstLaunchSuccessful) {
          if (state.isFirstLaunch) {
            router.goNamed(AppRoute.map.name);
          } else {
            router.goNamed(AppRoute.map.name);
          }
        }
      },
      child: Center(
        child: LottieBuilder.asset('assets/splashShiba.json'),
      ),
    );
  }
}
