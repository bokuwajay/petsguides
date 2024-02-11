import 'package:petsguides/features/auth/domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel({
    status,
    statusCode,
    token,
    detail,
    timestamp,
  }) : super(
          status: status,
          statusCode: statusCode,
          token: token,
          detail: detail,
          timestamp: timestamp,
        );

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      status: json['status'] ?? "",
      statusCode: json['statusCode'] ?? 0,
      token: json['data']?['token'] ?? "",
      detail: json['detail'] ?? "",
      timestamp: json['timestamp'] ?? "",
    );
  }
}
