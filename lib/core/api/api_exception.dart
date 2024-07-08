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

// below is differentiate by DioException type, throw in Api Interceptor
class ConnectionErrorException extends ApiException {
  ConnectionErrorException(String message) : super("Connection Error: ", message);
}

class ConnectionTimeOutException extends ApiException {
  ConnectionTimeOutException(String message) : super("Connection Time Out: ", message);
}

class SendTimeOutException extends ApiException {
  SendTimeOutException(String message) : super("Send Time Out: ", message);
}

class ReceiveTimeOutException extends ApiException {
  ReceiveTimeOutException(String message) : super("Receive Time Out: ", message);
}

class BadCertificateException extends ApiException {
  BadCertificateException(String message) : super("Bad SSL: ", message);
}

class CancelException extends ApiException {
  CancelException(String message) : super("Cancel Request: ", message);
}

class UnknownException extends ApiException {
  UnknownException(String message) : super("Unknown what happen: ", message);
}

// this is for status code 4xx and 5xx
class BadResponseException extends ApiException {
  BadResponseException(String message) : super('Bad Response: ', message);
}

// Socket Exception throw in Api Helper
class FetchDataException extends ApiException {
  FetchDataException(String message) : super("Error During Communication: ", message);
}

// below is differentiate by Status Code, throw in Api Helper
// StatusCode 400, throw this
class BadRequestException extends ApiException {
  BadRequestException(String message) : super("Invalid Request: ", message);
}

// StatusCode 401, throw this
class UnauthorizedException extends ApiException {
  UnauthorizedException(String message) : super("Unauthorized: ", message);
}

// StatusCode 403, throw this
class ForbiddenException extends ApiException {
  ForbiddenException(String message) : super("Forbidden: ", message);
}

// StatusCode 404, throw this
class NotFoundException extends ApiException {
  NotFoundException(String message) : super("Not Found: ", message);
}

// StatusCode 405, throw this
class MethodNotAllowedException extends ApiException {
  MethodNotAllowedException(String message) : super("Method Not Allowed: ", message);
}

// StatusCode 409, throw this
class DuplicatedDataException extends ApiException {
  DuplicatedDataException(String message) : super("Duplicated Data: ", message);
}

// StatusCode 422, throw this
class UnprocessableContentException extends ApiException {
  UnprocessableContentException(String message) : super("Unprocessable Content: ", message);
}

// StatusCode 500, throw this
class InternalServerException extends ApiException {
  InternalServerException(String message) : super("Internal Server: ", message);
}
