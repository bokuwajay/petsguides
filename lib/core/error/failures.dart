import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ConnectionErrorFailure extends Failure {
  const ConnectionErrorFailure({String suffix = ''}) : super("Connection Error: $suffix");
}

class ConnectionTimeOutFailure extends Failure {
  const ConnectionTimeOutFailure({String suffix = ''}) : super("Connection Time Out: $suffix");
}

class SendTimeOutFailure extends Failure {
  const SendTimeOutFailure({String suffix = ''}) : super("Send Time Out: $suffix");
}

class ReceiveTimeOutFailure extends Failure {
  const ReceiveTimeOutFailure({String suffix = ''}) : super("Receive Time Out: $suffix");
}

class BadCertificateFailure extends Failure {
  const BadCertificateFailure({String suffix = ''}) : super("Bad Certificate: $suffix");
}

class CancelFailure extends Failure {
  const CancelFailure({String suffix = ''}) : super("Cancel Failure: $suffix");
}

class FetchDataFailure extends Failure {
  const FetchDataFailure({String suffix = ''}) : super("Fetch Data Failure: $suffix");
}

class BadRequestFailure extends Failure {
  const BadRequestFailure({String suffix = ''}) : super("Bad Request: $suffix");
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({String suffix = ''}) : super("Unauthorized: $suffix");
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure({String suffix = ''}) : super("Forbidden: $suffix");
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({String suffix = ''}) : super("Not Found Resources: $suffix");
}

class MethodNotAllowedFailure extends Failure {
  const MethodNotAllowedFailure({String suffix = ''}) : super("Method Not Allowed: $suffix");
}

class DuplicatedDataFailure extends Failure {
  const DuplicatedDataFailure({String suffix = ''}) : super("Duplicated Data: $suffix");
}

class UnprocessableContentFailure extends Failure {
  const UnprocessableContentFailure({String suffix = ''}) : super("Unprocessable Content: $suffix");
}

class InternalServeFailure extends Failure {
  const InternalServeFailure({String suffix = ''}) : super("Internal Server Failure: $suffix");
}

class UnknownFailure extends Failure {
  const UnknownFailure({String suffix = ''}) : super("Unknown Failure: $suffix");
}

////
class ServerFailure extends Failure {
  const ServerFailure(super.suffix);
}

class CacheFailure extends Failure {
  const CacheFailure(super.suffix);
}

class CredentialFailure extends Failure {
  const CredentialFailure(super.suffix);
}

class MissingParamsFailure extends Failure {
  const MissingParamsFailure(super.suffix);
}
