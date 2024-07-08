// ignore_for_file: type_literal_in_constant_pattern

import 'package:petsguides/core/error/failures.dart';

String failureConverter(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return 'Server Failure ${failure.suffix}';
    case CacheFailure:
      return 'Cache Failure ${failure.suffix}';
    case CredentialFailure:
      return 'Wrong Email or Password ${failure.suffix}';
    case MissingParamsFailure:
      return 'Missing params ${failure.suffix}';
    default:
      return 'Unexpected error';
  }
}
