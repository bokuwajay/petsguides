// import 'package:dio/dio.dart';

// import 'exception_entity.dart';

// ExceptionEntity createExceptionEntity(DioException exception) {
//   switch (exception.type) {
//     case DioExceptionType.connectionTimeout:
//       return ExceptionEntity(
//         statusCode: -1,
//         exceptionMessage: "Connection timed out [Dio]",
//       );

//     case DioExceptionType.sendTimeout:
//       return ExceptionEntity(
//         statusCode: -2,
//         exceptionMessage: "Send timed out [Dio]",
//       );

//     case DioExceptionType.receiveTimeout:
//       return ExceptionEntity(
//         statusCode: -3,
//         exceptionMessage: "Receive timed out [Dio]",
//       );

//     case DioExceptionType.badCertificate:
//       return ExceptionEntity(
//         statusCode: -4,
//         exceptionMessage: "Bad SSL certificates [Dio]",
//       );

//     case DioExceptionType.cancel:
//       return ExceptionEntity(
//         statusCode: -5,
//         exceptionMessage: "Server canceled [Dio]",
//       );

//     case DioExceptionType.connectionError:
//       return ExceptionEntity(
//         statusCode: -6,
//         exceptionMessage: "Connection error [Dio]",
//       );

//     case DioExceptionType.badResponse:
//       switch (exception.response!.statusCode) {
//         case 400:
//           return ExceptionEntity(
//             statusCode: 400,
//             exceptionMessage: exception.response!.data['detail'],
//           );
//         case 401:
//           return ExceptionEntity(
//             statusCode: 401,
//             exceptionMessage: exception.response!.data['detail'],
//           );
//         case 403:
//           return ExceptionEntity(
//             statusCode: 403,
//             exceptionMessage: exception.response!.data['detail'],
//           );
//         case 405:
//           return ExceptionEntity(
//             statusCode: 405,
//             exceptionMessage: exception.response!.data['detail'],
//           );
//         case 409:
//           return ExceptionEntity(
//             statusCode: 409,
//             exceptionMessage: exception.response!.data['detail'],
//           );
//         case 500:
//           return ExceptionEntity(
//               statusCode: 500,
//               exceptionMessage:
//                   "Server internal error catch in Dio Interceptor");
//       }
//       return ExceptionEntity(
//           statusCode: exception.response!.statusCode!,
//           exceptionMessage: "Server bad response");

//     case DioExceptionType.unknown:
//       return ExceptionEntity(
//           statusCode: -7, exceptionMessage: "Unknown exception [Dio]");
//   }
// }
