import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsguides/core/util/dialogs/error_dialog.dart';
import 'package:petsguides/core/util/loading/loading_screen.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:petsguides/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:petsguides/features/auth/presentation/widgets/dialog/sign_in_dialog.dart';
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state.isLoading) {
          LoadingScreen().show(context: context);
        } else {
          LoadingScreen().hide();
          if (state is AuthStateLoggedIn) {
            SignInDialog().hide();
          } else if (state is AuthStateLoggedOut) {
            if (state.dioException is DioException) {
              await showErrorDialog(
                context,
                AppLocalizations.of(context)!.errorDialogTitle,
                state.dioException!.message.toString(),
                AppLocalizations.of(context)!.okBtn,
              );
            } else if (state.genericException is Exception) {
              await showErrorDialog(
                context,
                AppLocalizations.of(context)!.errorDialogTitle,
                state.genericException!.toString(),
                AppLocalizations.of(context)!.okBtn,
              );
            }
          }
        }
      },
      child: Stack(children: [
        Positioned(
          top: isSignUpView ? 140 : 220,
          child: Container(
            height: isSignUpView ? 520 : 320,
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
                              "Login",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color:
                                    isSignUpView ? Colors.black : Colors.amber,
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
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color:
                                    isSignUpView ? Colors.amber : Colors.black,
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
      ]),
    );
  }

  // Widget buildBottomHalfContainer(bool showShadow) {
  //   return AnimatedPositioned(
  //     duration: const Duration(milliseconds: 700),
  //     curve: Curves.bounceInOut,
  //     top: isSignUpView ? 535 : 430,
  //     right: 0,
  //     left: 0,
  //     child: Center(
  //       child: Container(
  //         height: 90,
  //         width: 90,
  //         padding: const EdgeInsets.all(15),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(50),
  //           boxShadow: [
  //             if (showShadow)
  //               BoxShadow(
  //                 color: Colors.black.withOpacity(.3),
  //                 spreadRadius: 1.5,
  //                 blurRadius: 10,
  //               )
  //           ],
  //         ),
  //         child: !showShadow
  //             ? Container(
  //                 decoration: BoxDecoration(
  //                   gradient: const LinearGradient(
  //                       colors: [Colors.orange, Colors.red],
  //                       begin: Alignment.topLeft,
  //                       end: Alignment.bottomRight),
  //                   borderRadius: BorderRadius.circular(30),
  //                   boxShadow: [
  //                     BoxShadow(
  //                         color: Colors.black.withOpacity(0.3),
  //                         spreadRadius: 1,
  //                         blurRadius: 2,
  //                         offset: const Offset(0, 1))
  //                   ],
  //                 ),
  //                 child: const Icon(
  //                   Icons.arrow_forward,
  //                   color: Colors.white,
  //                 ),
  //               )
  //             : const Center(),
  //       ),
  //     ),
  //   );
  // }
}
