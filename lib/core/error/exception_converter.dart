// ignore_for_file: type_literal_in_constant_pattern

import 'package:petsguides/core/error/exceptions.dart';
import 'package:petsguides/core/error/failures.dart';

Failure exceptionConverter(Object exception, String suffix) {
  switch (exception) {
    case ConnectionErrorException:
      return ConnectionErrorFailure(suffix: suffix);
    case ConnectionTimeOutException:
      return ConnectionTimeOutFailure(suffix: suffix);
    case SendTimeOutException:
      return SendTimeOutFailure(suffix: suffix);
    case ReceiveTimeOutException:
      return ReceiveTimeOutFailure(suffix: suffix);
    case BadCertificateException:
      return BadCertificateFailure(suffix: suffix);
    case CancelException:
      return CancelFailure(suffix: suffix);
    case FetchDataException:
      return FetchDataFailure(suffix: suffix);
    case BadRequestException:
      return BadRequestFailure(suffix: suffix);
    case UnauthorizedException:
      return UnauthorizedFailure(suffix: suffix);
    case ForbiddenException:
      return ForbiddenFailure(suffix: suffix);
    case NotFoundException:
      return NotFoundFailure(suffix: suffix);
    case MethodNotAllowedException:
      return MethodNotAllowedFailure(suffix: suffix);
    case DuplicatedDataException:
      return DuplicatedDataFailure(suffix: suffix);
    case UnprocessableContentException:
      return UnprocessableContentFailure(suffix: suffix);
    case InternalServerException:
      return InternalServeFailure(suffix: suffix);
    case CacheException:
      return CacheFailure(suffix: suffix);
    default:
      return UnknownFailure(suffix: suffix);
  }
}
