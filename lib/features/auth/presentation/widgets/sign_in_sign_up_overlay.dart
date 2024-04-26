import 'package:flutter/material.dart';
import 'package:petsguides/core/util/overlay/generic_overlay.dart';
import 'package:petsguides/features/auth/presentation/widgets/login_sign_up_view.dart';

class SignInSignUpOverlay extends StatelessWidget {
  const SignInSignUpOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GenericOverlay().hide();
      },
      child: Material(
        color: Colors.black.withAlpha(150),
        child: const Center(child: LoginSignUpView()),
      ),
    );
  }
}
