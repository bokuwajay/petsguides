import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsguides/core/util/validator.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:petsguides/components/build_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/pets_guides_localizations.dart';

class SignInSection extends StatefulWidget {
  const SignInSection({super.key});

  @override
  State<SignInSection> createState() => _SignInSectionState();
}

class _SignInSectionState extends State<SignInSection> with Validator {
  bool isRememberMe = false;

  late final TextEditingController _email;
  late final TextEditingController _password;
  final _formKey = GlobalKey<FormState>();

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
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: buildTextFormField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                hintText: AppLocalizations.of(context)!.email,
                prefixIcon: const Icon(Icons.email),
                validator: (value) =>
                    validateEmail(value, AppLocalizations.of(context)!.email),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: buildTextFormField(
                controller: _password,
                hintText: AppLocalizations.of(context)!.password,
                prefixIcon: const Icon(Icons.lock),
                obscureText: true,
                validator: (value) => validateRequiredField(
                    value, AppLocalizations.of(context)!.password),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // Implement forget password functionality
                  },
                  child: const Text(
                    "Forget Password?",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                )
              ],
            ),
            SizedBox(
              width: 160,
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
                child: Text(
                  AppLocalizations.of(context)!.login,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
