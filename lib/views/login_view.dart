import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:petsguides/service/dio/dio_interceptor.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final HttpUtil _httpUtil = HttpUtil();

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
    return Scaffold(
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
              // Initialize Dio
              final dio = Dio();

              try {
                // Replace with your backend server URL
                final response = await _httpUtil.post(
                  '/auth/authentication',
                  data: {
                    'email': email,
                    'password': password,
                  },
                );

                // Handle the response accordingly (e.g., check for success or display error)
                print('Response Status: ${response.statusCode}');
                print('Response Data: ${response.data}');

                // TODO: Handle success or error states based on the response
              } catch (error) {
                // Handle DioError (network error, timeout, etc.) or other exceptions
                print('Error: $error');
              }
            },
            child: const Text("Login"))
      ]),
    );
  }
}
