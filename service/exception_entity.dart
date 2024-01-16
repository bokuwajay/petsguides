class ExceptionEntity implements Exception {
  int statusCode = -1;
  String exceptionMessage = "";

  ExceptionEntity({
    required this.statusCode,
    required this.exceptionMessage,
  });

  @override
  String toString() {
    if (exceptionMessage == "") return "Exception";

    return "Exception Status Code: $statusCode; Exception Message: $exceptionMessage";
  }
}
