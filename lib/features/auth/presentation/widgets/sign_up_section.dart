import 'package:flutter/material.dart';
import 'package:petsguides/core/util/validator.dart';
import 'package:petsguides/widgets/build_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/pets_guides_localizations.dart';

class SignUpSection extends StatefulWidget {
  const SignUpSection({super.key});

  @override
  State<SignUpSection> createState() => _SignUpSectionState();
}

class _SignUpSectionState extends State<SignUpSection> with Validator {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _firstName;
  late final TextEditingController _lastName;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;
  late final TextEditingController _phone;

  @override
  void initState() {
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    _phone = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _phone.dispose();
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
                  controller: _firstName,
                  hintText: AppLocalizations.of(context)!.firstName,
                  validator: (value) => validateRequiredField(value, AppLocalizations.of(context)!.firstName),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: buildTextFormField(
                  controller: _lastName,
                  hintText: AppLocalizations.of(context)!.lastName,
                  validator: (value) => validateRequiredField(value, AppLocalizations.of(context)!.lastName),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: buildTextFormField(
                  controller: _email,
                  hintText: AppLocalizations.of(context)!.email,
                  validator: (value) => validateEmail(value, AppLocalizations.of(context)!.email),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: buildTextFormField(
                  controller: _password,
                  hintText: AppLocalizations.of(context)!.password,
                  prefixIcon: const Icon(Icons.lock),
                  obscureText: true,
                  validator: (value) => validateRequiredField(value, AppLocalizations.of(context)!.password),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: buildTextFormField(
                  controller: _confirmPassword,
                  hintText: AppLocalizations.of(context)!.repeatPassword,
                  prefixIcon: const Icon(Icons.lock),
                  obscureText: true,
                  validator: (value) => validateConfirmPassword(value, _password.text, AppLocalizations.of(context)!.repeatPassword),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: buildTextFormField(
                  controller: _phone,
                  hintText: AppLocalizations.of(context)!.phone,
                  validator: (value) => validatePhone(value, AppLocalizations.of(context)!.phone),
                ),
              ),
              SizedBox(
                width: 160,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // final firstName = _firstName.text;
                      // final lastName = _lastName.text;
                      // final email = _email.text;
                      // final password = _password.text;
                      // final confirmedPassword = _confirmPassword.text;
                      // final phone = _phone.text;
                    }
                  },
                  child: Text(
                    AppLocalizations.of(context)!.signUp,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
