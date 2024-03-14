import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:petsguides/core/util/secure_storage.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:petsguides/features/auth/presentation/pages/login_view.dart';
import 'package:petsguides/injection_container.dart';
import 'package:petsguides/config/themes/themes.dart';
// import 'package:petsguides/views/google_map.dart';
import 'package:flutter_gen/gen_l10n/pets_guides_localizations.dart';
import 'package:petsguides/views/main_view.dart';

// void main() async {
//   await initializeDependencies();
//   String deviceLanguage = Platform.localeName.substring(0, 2);
//   runApp(MaterialApp(
//     title: 'Flutter Home page',
//     theme: ThemeClass.lightTheme,
//     darkTheme: ThemeClass.darkTheme,
//     themeMode: ThemeMode.system,
//     localizationsDelegates: AppLocalizations.localizationsDelegates,
//     supportedLocales: AppLocalizations.supportedLocales,
//     locale: Locale(deviceLanguage),
//     home: BlocProvider<AuthBloc>(
//       create: (context) => sl(),
//       child: const HomePage(),
//     ),
//   ));
// }

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     context.read<AuthBloc>().add(const AuthEventInitialize());

//     return BlocBuilder<AuthBloc, AuthState>(
//       builder: (context, state) {
//         if (state is AuthStateLoggedIn) {
//           return const GoogleMapView();
//         } else if (state is AuthStateLoggedOut) {
//           return const LoginView();
//         } else {
//           return const CircularProgressIndicator();
//           // return const LoginView();
//         }
//       },
//     );
//   }
// },

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
      child: MaterialApp(
        title: 'Flutter Home page',
        theme: ThemeClass.lightTheme,
        darkTheme: ThemeClass.darkTheme,
        themeMode: ThemeMode.system,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _locale,
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const MainView();
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
