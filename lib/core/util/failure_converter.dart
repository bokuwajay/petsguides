import 'package:petsguides/core/error/failures.dart';

String failureConverter(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return "Server Failure";
    case CacheFailure:
      return "Cache Failure";
    case CredentialFailure:
      return "Wrong Email or Password";
    default:
      return "Unexpected error";
  }
}
