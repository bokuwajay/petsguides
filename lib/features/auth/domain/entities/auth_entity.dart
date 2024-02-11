import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? status;
  final int? statusCode;
  final String? token;
  final String? detail;
  final String? timestamp;

  const AuthEntity({
    this.status,
    this.statusCode,
    this.token,
    this.detail,
    this.timestamp,
  });

// this is from Equatable and aim for object comparison
// which help later in managing state in BloC
  @override
  List<Object?> get props {
    return [
      status,
      statusCode,
      token,
      detail,
      timestamp,
    ];
  }
}
