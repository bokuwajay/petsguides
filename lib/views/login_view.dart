import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsguides/blocs/auth/auth_bloc.dart';
import 'package:petsguides/blocs/auth/auth_event.dart';
import 'package:petsguides/blocs/auth/auth_state.dart';
import 'package:petsguides/services/auth/auth_exceptions.dart';
import 'package:petsguides/views/dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
          if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(context, "user not found");
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(context, "Wrong credentials");
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, "Authentication error");
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Login Page")),
        body: Column(children: [
          TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: "Email")),
          TextField(
              controller: _password,
              enableSuggestions: false,
              autocorrect: false,
              obscureText: true,
              decoration: const InputDecoration(hintText: "Password")),
          TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;

                context
                    .read<AuthBloc>()
                    .add(AuthEventLogIn(email: email, password: password));
              },
              child: const Text("Login"))
        ]),
      ),
    );
  }
}
