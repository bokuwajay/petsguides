import 'package:petsguides/features/auth/domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel({
    status,
    statusCode,
    data,
    detail,
    timestamp,
  }) : super(
          status: status,
          statusCode: statusCode,
          data: data,
          detail: detail,
          timestamp: timestamp,
        );

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      status: json['status'] ?? "",
      statusCode: json['statusCode'] ?? 0,
      data: json['data'] ?? "",
      detail: json['detail'] ?? "",
      timestamp: json['timestamp'] ?? "",
    );
  }
}
