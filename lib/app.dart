import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsguides/config/routes/app_route_config.dart';
import 'package:petsguides/core/util/secure_storage.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:petsguides/injection_container.dart';
import 'package:petsguides/config/themes/themes.dart';
import 'package:flutter_gen/gen_l10n/pets_guides_localizations.dart';

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
    final router = sl.get<AppRouteConfig>().router;

    return BlocProvider<AuthBloc>(
      create: (context) => sl.get<AuthBloc>(),
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
