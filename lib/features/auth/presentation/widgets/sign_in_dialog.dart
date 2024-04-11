import 'package:flutter/material.dart';
import 'package:petsguides/features/auth/presentation/pages/login_sign_up_view.dart';
import 'package:petsguides/features/auth/presentation/widgets/sign_in_dialog_controller.dart';

class SignInDialog {
  factory SignInDialog() => _shared;
  static final SignInDialog _shared = SignInDialog._sharedInstance();
  SignInDialog._sharedInstance();

  SignInDialogController? controller;

  void show({required BuildContext context}) {
    controller = showOverlay(context: context);
  }

  void hide() {
    controller?.close();
    controller = null;
  }

  SignInDialogController showOverlay({required BuildContext context}) {
    final state = Overlay.of(context);

    final overlay = OverlayEntry(
      builder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: hide,
          child: Material(
            color: Colors.black.withAlpha(150),
            child: const Center(child: LoginSignUpView()),
          ),
        );
      },
    );
    state.insert(overlay);
    return SignInDialogController(close: () {
      overlay.remove();
      return true;
    });
  }
}
