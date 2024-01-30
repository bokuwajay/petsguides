// login exceptions
class UserNotFoundAuthException implements Exception {
  String exceptionMessage = "";

  UserNotFoundAuthException({required this.exceptionMessage});

  @override
  String toString() {
    if (exceptionMessage == "") return "User Not Found!";

    return exceptionMessage;
  }
}

class WrongPasswordAuthException implements Exception {}

// register exceptions
class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

// generic exceptions
class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}
