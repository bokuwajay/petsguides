import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:petsguides/config/routes/routes.dart';
import 'package:petsguides/core/util/secure_storage.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:petsguides/features/auth/presentation/pages/get_started_view.dart';
// import 'package:petsguides/features/auth/presentation/pages/login_sign_up_view.dart';
import 'package:petsguides/features/auth/presentation/pages/login_view.dart';
import 'package:petsguides/features/market/presentation/pages/market_view.dart';
// import 'package:petsguides/features/market/presentation/pages/market_view.dart';
import 'package:petsguides/injection_container.dart';
import 'package:petsguides/config/themes/themes.dart';
// import 'package:petsguides/views/google_map.dart';
import 'package:flutter_gen/gen_l10n/pets_guides_localizations.dart';
// import 'package:petsguides/components/sidebar/side_bar.dart';

void main() async {
  if (kDebugMode) {
    await dotenv.load(fileName: 'assets/env/.env.development');
  } else {
    await dotenv.load(fileName: 'assets/env/.env.production');
  }
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale lang) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(lang);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  @override
  void initState() {
    _locale = sl<Locale>();
    super.initState();
  }

  setLocale(Locale lang) async {
    setState(() {
      _locale = lang;
    });
    await SecureStorage.writeSecureData('language', lang.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => sl(),
      child: MaterialApp.router(
        title: 'Flutter Home page',
        theme: ThemeClass.lightTheme,
        darkTheme: ThemeClass.darkTheme,
        themeMode: ThemeMode.system,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _locale,
        routerConfig: router,
      ),
    );
  }
}

class InitPage extends StatelessWidget {
  const InitPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());

    return BlocBuilder<AuthBloc, AuthState>(
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
          return const CircularProgressIndicator();
          // return const LoginView();
        }
      },
    );
  }
}
