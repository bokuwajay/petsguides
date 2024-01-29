// class ApiResponse {
//   final String status;
//   final int statusCode;
//   final ApiResponseData data;
//   final String detail;
//   final String timestamp;

//   ApiResponse({
//     required this.status,
//     required this.statusCode,
//     required this.data,
//     required this.detail,
//     required this.timestamp,
//   });

//   factory ApiResponse.fromJson(Map<String, dynamic> json) {
//     return ApiResponse(
//       status: json['status'] as String,
//       statusCode: json['statusCode'] as int,
//       data: ApiResponseData.fromJson(json['data']),
//       detail: json['detail'] as String,
//       timestamp: json['timestamp'] as String,
//     );
//   }
// }

// class ApiResponseData {
//   final String token;

//   ApiResponseData({required this.token});

//   factory ApiResponseData.fromJson(Map<String, dynamic> json) {
//     return ApiResponseData(
//       token: json['token'] as String,
//     );
//   }
// }
