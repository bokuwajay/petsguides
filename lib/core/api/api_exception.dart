class ApiException implements Exception {
  final String prefix;
  final String message;

  ApiException([
    this.prefix = "",
    this.message = "",
  ]);

  @override
  String toString() {
    return "$prefix $message";
  }
}

class FetchDataException extends ApiException {
  FetchDataException(String message) : super("Error During Communication: ", message);
}

class BadRequestException extends ApiException {
  BadRequestException(String message) : super("Invalid Request: ", message);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(String message) : super("Unauthorized: ", message);
}

class ForbiddenException extends ApiException {
  ForbiddenException(String message) : super("Forbidden: ", message);
}

class NotFoundException extends ApiException {
  NotFoundException(String message) : super("Not Found: ", message);
}

class MethodNotAllowedException extends ApiException {
  MethodNotAllowedException(String message) : super("Method Not Allowed: ", message);
}

class DuplicatedDataException extends ApiException {
  DuplicatedDataException(String message) : super("Duplicated Data: ", message);
}

class InternalServerException extends ApiException {
  InternalServerException(String message) : super("Internal Server: ", message);
}

class UnprocessableContentException extends ApiException {
  UnprocessableContentException(String message) : super("Unprocessable Content: ", message);
}

class InvalidInputException extends ApiException {
  InvalidInputException(String message) : super("Invalid Input: ", message);
}
