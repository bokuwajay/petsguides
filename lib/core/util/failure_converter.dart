// ignore_for_file: type_literal_in_constant_pattern

import 'package:petsguides/core/error/failures.dart';

String failureConverter(Failure failure) {
  switch (failure.runtimeType) {
    case ConnectionErrorFailure:
      return failure.message;
    case ConnectionTimeOutFailure:
      return failure.message;
    case SendTimeOutFailure:
      return failure.message;
    case ReceiveTimeOutFailure:
      return failure.message;
    case BadCertificateFailure:
      return failure.message;
    case CancelFailure:
      return failure.message;
    case FetchDataFailure:
      return failure.message;
    case BadRequestFailure:
      return failure.message;
    case UnauthorizedFailure:
      return failure.message;
    case ForbiddenFailure:
      return failure.message;
    case NotFoundFailure:
      return failure.message;
    case MethodNotAllowedFailure:
      return failure.message;
    case DuplicatedDataFailure:
      return failure.message;
    case UnprocessableContentFailure:
      return failure.message;
    case InternalServeFailure:
      return failure.message;
    case CacheFailure:
      return failure.message;
    case MissingParamsFailure:
      return failure.message;
    default:
      return failure.message;
  }
}
