import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

// network related
class ConnectionErrorFailure extends Failure {
  ConnectionErrorFailure({String suffix = ''}) : super("Connection Error: $suffix Timestamp: ${DateTime.now().toString()}");
}

class ConnectionTimeOutFailure extends Failure {
  ConnectionTimeOutFailure({String suffix = ''}) : super("Connection Time Out: $suffix Timestamp: ${DateTime.now().toString()}");
}

// system related
class FetchDataFailure extends Failure {
  FetchDataFailure({String suffix = ''}) : super("Fetch Data Failure: $suffix Timestamp: ${DateTime.now().toString()}");
}

class SendTimeOutFailure extends Failure {
  SendTimeOutFailure({String suffix = ''}) : super("Send Time Out: $suffix Timestamp: ${DateTime.now().toString()}");
}

class ReceiveTimeOutFailure extends Failure {
  ReceiveTimeOutFailure({String suffix = ''}) : super("Receive Time Out: $suffix Timestamp: ${DateTime.now().toString()}");
}

class BadCertificateFailure extends Failure {
  BadCertificateFailure({String suffix = ''}) : super("Bad Certificate: $suffix Timestamp: ${DateTime.now().toString()}");
}

class CancelFailure extends Failure {
  CancelFailure({String suffix = ''}) : super("Cancel Failure: $suffix Timestamp: ${DateTime.now().toString()}");
}

class MethodNotAllowedFailure extends Failure {
  MethodNotAllowedFailure({String suffix = ''}) : super("Method Not Allowed: $suffix Timestamp: ${DateTime.now().toString()}");
}

class UnprocessableContentFailure extends Failure {
  UnprocessableContentFailure({String suffix = ''}) : super("Unprocessable Content: $suffix Timestamp: ${DateTime.now().toString()}");
}

class InternalServeFailure extends Failure {
  InternalServeFailure({String suffix = ''}) : super("Internal Server Failure: $suffix Timestamp: ${DateTime.now().toString()}");
}

class BadRequestFailure extends Failure {
  BadRequestFailure({String suffix = ''}) : super("Bad Request: $suffix Timestamp: ${DateTime.now().toString()}");
}

class NotFoundFailure extends Failure {
  NotFoundFailure({String suffix = ''}) : super("Not Found Resources: $suffix Timestamp: ${DateTime.now().toString()}");
}

class CacheFailure extends Failure {
  CacheFailure({String suffix = ''}) : super("Cache Failure: $suffix Timestamp: ${DateTime.now().toString()}");
}

// user related
class UnauthorizedFailure extends Failure {
  UnauthorizedFailure({String suffix = ''}) : super("Unauthorized: $suffix Timestamp: ${DateTime.now().toString()}");
}

class ForbiddenFailure extends Failure {
  ForbiddenFailure({String suffix = ''}) : super("Forbidden: $suffix Timestamp: ${DateTime.now().toString()}");
}

class DuplicatedDataFailure extends Failure {
  DuplicatedDataFailure({String suffix = ''}) : super("Duplicated Data: $suffix Timestamp: ${DateTime.now().toString()}");
}

class MissingParamsFailure extends Failure {
  MissingParamsFailure({String suffix = ''}) : super("Missing Params Failure: $suffix Timestamp: ${DateTime.now().toString()}");
}

// Unexpected

class UnknownFailure extends Failure {
  UnknownFailure({String suffix = ''}) : super("Unknown Failure: $suffix Timestamp: ${DateTime.now().toString()}");
}
