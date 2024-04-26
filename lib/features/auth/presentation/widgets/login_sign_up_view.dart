import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petsguides/features/auth/presentation/widgets/sign_in_section.dart';
import 'package:petsguides/features/auth/presentation/widgets/sign_up_section.dart';
import 'package:flutter_gen/gen_l10n/pets_guides_localizations.dart';

class LoginSignUpView extends StatefulWidget {
  const LoginSignUpView({super.key});

  @override
  State<LoginSignUpView> createState() => _LoginSignUpViewState();
}

class _LoginSignUpViewState extends State<LoginSignUpView> {
  bool isMale = true;
  bool isSignUpView = true;
  bool isRememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: isSignUpView ? 140 : 220,
        child: Container(
          height: isSignUpView ? 580 : 320,
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width - 40,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 5)
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSignUpView = false;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.login,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isSignUpView ? Colors.black : Colors.amber,
                            ),
                          ),
                          if (!isSignUpView)
                            Container(
                              margin: const EdgeInsets.only(top: 3),
                              height: 2,
                              width: 55,
                              color: Colors.orange,
                            )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSignUpView = true;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.signUp,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isSignUpView ? Colors.amber : Colors.black,
                            ),
                          ),
                          if (isSignUpView)
                            Container(
                              margin: const EdgeInsets.only(top: 3),
                              height: 2,
                              width: 55,
                              color: Colors.orange,
                            )
                        ],
                      ),
                    )
                  ],
                ),
                if (isSignUpView) const SignUpSection(),
                if (!isSignUpView) const SignInSection(),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
