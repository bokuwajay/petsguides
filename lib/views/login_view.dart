import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsguides/blocs/auth/auth_bloc.dart';
import 'package:petsguides/blocs/auth/auth_event.dart';
import 'package:petsguides/blocs/auth/auth_state.dart';
import 'package:petsguides/exceptions/auth_exceptions.dart';
import 'package:petsguides/exceptions/connection_exception.dart';
import 'package:petsguides/helpers/validator.dart';
import 'package:petsguides/views/dialogs/error_dialog.dart';

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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is AuthException) {
            await showErrorDialog(context, state.exception.toString());
          } else if (state.exception is ConnectionException) {
            await showErrorDialog(context, state.exception.toString());
          }
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
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
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/login/background-2.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: <Widget>[
                  FadeIn(
                    duration: const Duration(milliseconds: 1500),
                    child: const Text(
                      "Login",
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
                                  controller: _email,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    hintText: "Email",
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(0),
                                      child: Icon(Icons.email),
                                    ),
                                  ),
                                  validator: (value) => validateEmail(value),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: TextFormField(
                                  controller: _password,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  obscureText: hidePassword,
                                  decoration: InputDecoration(
                                    hintText: "Password",
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
                                            icon: Icon(hidePassword
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                          )
                                        : null,
                                  ),
                                  validator: (value) =>
                                      validateRequiredField(value, "Password"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  const SizedBox(height: 20),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1800),
                    child: const Center(
                      child: Text(
                        'Forget Password?',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1900),
                    child: Container(
                      width: 280,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
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
                        child: const Text(
                          "Login",
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
                    child: const Center(
                      child: Text(
                        'Create Account',
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
