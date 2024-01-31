// login exceptions
class AuthException implements Exception {
  String exceptionMessage = "";

  AuthException({required this.exceptionMessage});

  @override
  String toString() {
    if (exceptionMessage == "") return "Authentication Error!";

    return exceptionMessage;
  }
}

// class WrongPasswordAuthException implements Exception {}

// // register exceptions
// class WeakPasswordAuthException implements Exception {}

// class EmailAlreadyInUseAuthException implements Exception {}

// class InvalidEmailAuthException implements Exception {}

// // generic exceptions
// class GenericAuthException implements Exception {}

// class UserNotLoggedInAuthException implements Exception {}
