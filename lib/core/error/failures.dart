import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  final String suffix;

  const Failure(this.suffix);

  @override
  List<Object> get props => [suffix];
}

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
