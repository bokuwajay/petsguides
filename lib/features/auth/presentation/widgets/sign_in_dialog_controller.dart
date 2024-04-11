import 'package:flutter/foundation.dart' show immutable;

typedef CloseSignInDialog = bool Function();

@immutable
class SignInDialogController {
  final CloseSignInDialog close;

  const SignInDialogController({
    required this.close,
  });
}
