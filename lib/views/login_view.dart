import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsguides/blocs/auth/auth_bloc.dart';
import 'package:petsguides/blocs/auth/auth_event.dart';
import 'package:petsguides/blocs/auth/auth_state.dart';
import 'package:petsguides/exceptions/auth_exceptions.dart';
import 'package:petsguides/exceptions/connection_exception.dart';
import 'package:petsguides/helpers/validator.dart';
import 'package:petsguides/views/dialogs/error_dialog.dart';

final _formKey = GlobalKey<FormState>();

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with Validator {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        appBar: AppBar(title: Text("Login Page")),
        body: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: "Email"),
              validator: (value) => validateEmail(value),
            ),
            TextFormField(
              controller: _password,
              enableSuggestions: false,
              autocorrect: false,
              obscureText: true,
              decoration: const InputDecoration(hintText: "Password"),
              validator: (value) => validateRequiredField(value, "Password"),
            ),
            TextButton(
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
                child: const Text("Login"))
          ]),
        ),
      ),
    );
  }
}
