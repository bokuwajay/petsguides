import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsguides/app.dart';
import 'package:petsguides/core/constants/languages.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:petsguides/core/util/validator.dart';
import 'package:flutter_gen/gen_l10n/pets_guides_localizations.dart';
import 'package:petsguides/google_login.dart';

import 'package:snappable_thanos/snappable_thanos.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with Validator {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool hidePassword = true;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<SnappableState> _snappableKey = GlobalKey<SnappableState>();

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _password.addListener(_updateSuffixIconVisibility);
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _updateSuffixIconVisibility() {
    setState(() {
      hidePassword = _password.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    // obtain the width of current screen
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Snappable(
            key: _snappableKey,
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                SizedBox(
                  height: 400,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          top: -40,
                          height: 400,
                          width: width,
                          child: FadeInUp(
                            duration: const Duration(milliseconds: 1000),
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/login/background.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          )),
                      Positioned(
                          height: 400,
                          width: width + 20,
                          child: FadeInUp(
                            duration: const Duration(milliseconds: 1000),
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(image: AssetImage('assets/login/background-2.png'), fit: BoxFit.fill),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: DropdownButton<Language>(
                    underline: const SizedBox(),
                    icon: const Icon(
                      Icons.language,
                      color: Colors.white,
                    ),
                    items: Language.languageList()
                        .map(
                          (e) => DropdownMenuItem<Language>(
                            value: e,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[Text(e.label)],
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (Language? lang) {
                      if (lang != null) {
                        SnappableState state = _snappableKey.currentState!;
                        if (state.isInProgress) {
                          // do nothing
                          debugPrint("Animation is in progress, please wait!");
                        } else if (state.isGone) {
                          state.reset();
                        } else {
                          state.snap();
                        }
                        Future.delayed(Duration(milliseconds: 1280), () {
                          MyApp.setLocale(context, Locale(lang.languageCode, ''));
                        });
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      FadeIn(
                        duration: const Duration(milliseconds: 1500),
                        child: Text(
                          AppLocalizations.of(context)!.login,
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FadeInUp(
                          duration: const Duration(milliseconds: 1700),
                          child: Form(
                            key: _formKey,
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: TextFormField(
                                        onTapOutside: (event) => FocusScope.of(context).unfocus(),
                                        controller: _email,
                                        enableSuggestions: false,
                                        autocorrect: false,
                                        keyboardType: TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          hintText: AppLocalizations.of(context)!.email,
                                          prefixIcon: const Padding(
                                            padding: EdgeInsets.all(0),
                                            child: Icon(Icons.email),
                                          ),
                                        ),
                                        validator: (value) => validateEmail(value, AppLocalizations.of(context)!.email)),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: TextFormField(
                                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                                      controller: _password,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      obscureText: hidePassword,
                                      decoration: InputDecoration(
                                        hintText: AppLocalizations.of(context)!.password,
                                        prefixIcon: const Padding(
                                          padding: EdgeInsets.all(0),
                                          child: Icon(Icons.lock),
                                        ),
                                        suffixIcon: _password.text.isNotEmpty
                                            ? IconButton(
                                                onPressed: () => setState(
                                                  () {
                                                    hidePassword = !hidePassword;
                                                  },
                                                ),
                                                icon: Icon(hidePassword ? Icons.visibility : Icons.visibility_off),
                                              )
                                            : null,
                                      ),
                                      validator: (value) => validateRequiredField(value, AppLocalizations.of(context)!.password),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      const SizedBox(height: 20),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1800),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.forgetPassword,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1900),
                        child: Container(
                          width: 280,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final email = _email.text;
                                final password = _password.text;

                                context.read<AuthBloc>().add(AuthEventLogIn(
                                      email: email,
                                      password: password,
                                    ));

                                _formKey.currentState!.reset();
                              }
                            },
                            child: Text(
                              AppLocalizations.of(context)!.login,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FadeInUp(
                        duration: const Duration(milliseconds: 2000),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.signUp,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      FadeInUp(
                        duration: const Duration(milliseconds: 2000),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                          onPressed: () async {
                            var user = await GoogleLogin.login();
                            if (user != null) {
                              print('Login OK!!!!');
                              print('inform----------$user');
                            }
                          },
                          child: const Text(
                            "Google Sign In",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      FadeInUp(
                        duration: const Duration(milliseconds: 2000),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                          onPressed: () async {
                            await GoogleLogin.signOut;
                          },
                          child: const Text(
                            "Google Log Out",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
            onSnapped: () => _snappableKey.currentState!.reset()));
  }
}
