// below is differentiate by DioException type, throw in Api Helper
class ConnectionErrorException implements Exception {}

class ConnectionTimeOutException implements Exception {}

class SendTimeOutException implements Exception {}

class ReceiveTimeOutException implements Exception {}

class BadCertificateException implements Exception {}

class CancelException implements Exception {}

class UnknownException implements Exception {}

// this one is for SocketException, throw in in Api Helper
class FetchDataException implements Exception {}

// below is differentiate by Status Code (4xx to 5xx), throw in Api Helper
// StatusCode 400, throw this
class BadRequestException implements Exception {}

// StatusCode 401, throw this
class UnauthorizedException implements Exception {}

// StatusCode 403, throw this
class ForbiddenException implements Exception {}

// StatusCode 404, throw this
class NotFoundException implements Exception {}

// StatusCode 405, throw this
class MethodNotAllowedException implements Exception {}

// StatusCode 409, throw this
class DuplicatedDataException implements Exception {}

// StatusCode 422, throw this
class UnprocessableContentException implements Exception {}

// StatusCode 500 (500 or higher imply a Bad response from the server), throw this
class InternalServerException implements Exception {}

/////
class ServerException implements Exception {}

class CacheException implements Exception {}

class AuthException implements Exception {}

class EmptyException implements Exception {}
