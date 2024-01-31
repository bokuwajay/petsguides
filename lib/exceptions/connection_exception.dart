class ConnectionException implements Exception {
  String exceptionMessage = "";

  ConnectionException({required this.exceptionMessage});

  @override
  String toString() {
    if (exceptionMessage == "") return "Connection Error!";

    return exceptionMessage;
  }
}
